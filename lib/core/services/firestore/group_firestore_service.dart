import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rewire/core/utils/security_helper.dart';
import 'package:rewire/features/group/data/models/group_model.dart';

import 'checkin_firestore_service.dart';

class GroupFirestoreService {
  final FirebaseFirestore _firestore;
  final CheckinFirestoreService _checkinService;

  static const int _batchLimit = 400;

  GroupFirestoreService(this._firestore, this._checkinService);

  // =====================
  // Collections
  // =====================

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('groups');

  // =====================
  // Groups
  // =====================

  Future<GroupModel> createGroup(GroupModel group) async {
    final docRef = _groups.doc();
    group = group.copyWith(id: docRef.id);

    await docRef
        .set(group.toMap())
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () => throw 'Connection timeout',
        );

    return group;
  }

  Future<List<GroupModel>> getUserGroups(String uid) async {
    final query = await _groups
        .where('members', arrayContains: uid)
        .where('isActive', isEqualTo: true)
        .get();

    return query.docs.map((doc) => GroupModel.fromMap(doc.data())).toList();
  }

  /// Filters to only groups that have more than 1 member (leaderboard-eligible).
  List<GroupModel> filterGroupsWithLeaderboard(List<GroupModel> groups) {
    return groups.where((group) => group.members.length > 1).toList();
  }

  Future<void> addMember({
    required String groupId,
    required String userId,
  }) async {
    // Update group atomically then ensure today's check-in exists
    await _groups.doc(groupId).update({
      'members': FieldValue.arrayUnion([userId]),
      'memberCommitments.$userId': 0,
    });

    await _checkinService.createDayIfNotExist(userId: userId, groupId: groupId);
  }

  Stream<List<GroupModel>> listenToGroups(String userId) {
    return _groups
        .where('members', arrayContains: userId)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((e) => GroupModel.fromMap(e.data())).toList(),
        );
  }

  /// Deletes a group and all its subcollections (messages, days, check-ins).
  /// Uses batched deletes to stay within Firestore limits.
  Future<void> deleteGroup(String groupId) async {
    final groupRef = _groups.doc(groupId);

    // Fetch messages and days in parallel
    final results = await Future.wait([
      groupRef.collection('messages').get(),
      groupRef.collection('days').get(),
    ]);

    final messages = results[0];
    final days = results[1];

    // Fetch all checkin subcollections in parallel
    final checkInSnapshots = await Future.wait(
      days.docs.map((day) => day.reference.collection('checkins').get()),
    );

    var batch = _firestore.batch();
    int batchCount = 0;

    Future<void> addToBatch(DocumentReference ref) async {
      batch.delete(ref);
      batchCount++;
      if (batchCount >= _batchLimit) {
        await batch.commit();
        batch = _firestore.batch();
        batchCount = 0;
      }
    }

    // Delete messages
    for (final doc in messages.docs) {
      await addToBatch(doc.reference);
    }

    // Delete check-ins then their parent day docs
    for (int i = 0; i < days.docs.length; i++) {
      for (final checkin in checkInSnapshots[i].docs) {
        await addToBatch(checkin.reference);
      }
      await addToBatch(days.docs[i].reference);
    }

    // Flush remaining
    if (batchCount > 0) {
      await batch.commit();
    }

    // Delete the group document itself last
    await groupRef.delete();
  }

  Future<void> updateGroup({
    required String groupId,
    required String? newName,
    required String? newPassword,
  }) async {
    final Map<String, dynamic> data = {};

    if (newName != null && newName.trim().isNotEmpty) {
      data['name'] = newName.trim();
    }

    if (newPassword != null && newPassword.isNotEmpty) {
      data['passwordHash'] = SecurityHelper.hashPassword(newPassword);
    }

    if (data.isEmpty) return;

    await _groups
        .doc(groupId)
        .update(data)
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () => throw 'Connection timeout',
        );
  }

  Future<GroupModel?> getGroupById(String groupId) async {
    final doc = await _groups.doc(groupId).get();
    if (!doc.exists) return null;
    return GroupModel.fromMap(doc.data()!);
  }

  Future<void> updateGroupImageTimestamp(String groupId) async {
    await _groups.doc(groupId).update({
      'imageUpdatedAt': FieldValue.serverTimestamp(),
    });
  }
}
