import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rewire/core/utils/code_generator.dart';
import 'package:rewire/core/utils/security_helper.dart';
import 'package:rewire/features/profile_view/data/models/user_model.dart';

import 'checkin_firestore_service.dart';
import 'user_firestore_service.dart';

class GroupMembershipFirestoreService {
  final FirebaseFirestore _firestore;
  final CheckinFirestoreService _checkinService;
  final UserFirestoreService _userService;

  GroupMembershipFirestoreService(
    this._firestore,
    this._checkinService,
    this._userService,
  );

  // =====================
  // Collections
  // =====================

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('habits');

  // =====================
  // Join Group
  // =====================

  Future<void> joinGroup({
    required String joinCode,
    required String password,
    required String userId,
  }) async {
    final trimmedCode = joinCode.trim().toUpperCase();

    if (trimmedCode.length != 6) throw 'Group not found';

    final query = await _groups
        .where('joinCode', isEqualTo: trimmedCode)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      throw ('Group not found');
    }

    final doc = query.docs.first;
    final data = doc.data();

    if (data['members'].contains(userId)) {
      throw ('You already joined this group');
    }

    final String storedHash = data['passwordHash'] ?? '';

    if (storedHash.isNotEmpty) {
      final enteredHash = SecurityHelper.hashPassword(password);

      if (storedHash != enteredHash) {
        throw ('Wrong password');
      }
    }

    await doc.reference.update({
      'members': FieldValue.arrayUnion([userId]),
      'memberCommitments.$userId': 0,
    });

    await _checkinService.createDayIfNotExist(
      habitId: doc.id,
      userId: userId,
    );
  }

  Future<void> joinGroupViaId({
    required String groupId,
    required String userId,
  }) async {
    final docRef = _groups.doc(groupId);
    final doc = await docRef.get();

    if (!doc.exists) {
      throw ('Group not found');
    }

    final data = doc.data()!;

    if ((data['members'] as List).contains(userId)) {
      throw ('You already joined this group');
    }

    await docRef.update({
      'members': FieldValue.arrayUnion([userId]),
      'memberCommitments.$userId': 0,
    });

    await _checkinService.createDayIfNotExist(
      habitId: groupId,
      userId: userId,
    );
  }

  Future<String> generateUniqueJoinCode() async {
    while (true) {
      final code = generateJoinCode();
      final existing = await _groups
          .where('joinCode', isEqualTo: code)
          .limit(1)
          .get();
      if (existing.docs.isEmpty) return code;
    }
  }

  // =====================
  // Get Join Code
  // =====================

  Future<String?> getJoinCode(String habitId) async {
    final doc = await _groups.doc(habitId).get();

    if (!doc.exists) return null;

    return doc.data()?['joinCode'];
  }

  // =====================
  // Remove / Leave Member
  // =====================

  Future<void> removeMember({
    required String groupId,
    required String userId,
  }) async {
    await _groups.doc(groupId).update({
      'members': FieldValue.arrayRemove([userId]),
      'memberCommitments.$userId': FieldValue.delete(),
    });
  }

  Future<void> leaveGroup({
    required String groupId,
    required String userId,
  }) => removeMember(groupId: groupId, userId: userId);

  // =====================
  // Group Members
  // =====================

  Future<List<UserModel>> getGroupMembers(String groupId) async {
    final doc = await _groups.doc(groupId).get();
    if (!doc.exists) return [];

    final memberIds = List<String>.from(doc.data()?['members'] ?? []);

    final results = await Future.wait(
      memberIds.map((id) => _userService.getUser(id)),
    );

    return results.whereType<UserModel>().toList();
  }

  Stream<List<UserModel>> listenToGroupMembers(String groupId) {
    return _groups.doc(groupId).snapshots().asyncMap((doc) async {
      if (!doc.exists) return [];

      final List<String> memberIds = List<String>.from(
        doc.data()?['members'] ?? [],
      );

      // Fetch all users in parallel with a safety timeout per fetch
      final userModels = await Future.wait(
        memberIds.map(
          (id) => _userService.getUser(id).timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              log('Timeout fetching user: $id');
              return null;
            },
          ),
        ),
      );

      // Filter out nulls and return valid users
      return userModels.whereType<UserModel>().toList();
    });
  }
}
