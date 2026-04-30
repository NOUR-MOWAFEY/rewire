import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rewire/core/utils/security_helper.dart';
import 'package:rewire/features/group/data/models/group_model.dart';

import 'checkin_firestore_service.dart';

class GroupFirestoreService {
  final FirebaseFirestore _firestore;
  final CheckinFirestoreService _checkinService;

  GroupFirestoreService(this._firestore, this._checkinService);

  // =====================
  // Collections
  // =====================

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('habits');

  // =====================
  // Groups
  // =====================

  Future<GroupModel> createGroup(GroupModel group) async {
    final docRef = _groups.doc();
    group = group.copyWith(id: docRef.id);

    await docRef
        .set(group.toMap())
        .timeout(
          Duration(seconds: 5),
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

  List<GroupModel> filterGroupsWithLeaderboard(List<GroupModel> groups) {
    return groups.where((group) => group.members.length > 1).toList();
  }

  Future<void> addMembers({
    required String groupId,
    required String userId,
  }) async {
    await _groups.doc(groupId).update({
      'members': FieldValue.arrayUnion([userId]),
      'memberCommitments.$userId': 0,
    });

    await _checkinService.createDayIfNotExist(habitId: groupId, userId: userId);
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

  Future<void> deleteGroup(String habitId) async {
    final habitRef = _groups.doc(habitId);

    // Delete messages
    final messages = await habitRef.collection('messages').get();
    for (var doc in messages.docs) {
      await doc.reference.delete();
    }

    // Delete days + checkins
    final days = await habitRef.collection('days').get();
    for (var day in days.docs) {
      final checkins = await day.reference.collection('checkins').get();

      for (var checkin in checkins.docs) {
        await checkin.reference.delete();
      }

      await day.reference.delete();
    }

    // Delete habit document
    await habitRef.delete();
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
}
