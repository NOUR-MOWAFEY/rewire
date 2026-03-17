import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/utils/code_generator.dart';
import 'package:rewire/core/utils/security_helper.dart';
import 'package:rewire/features/home/data/models/day_model.dart';

import '../../features/home/data/models/checkin_model.dart';
import '../../features/home/data/models/group_model.dart';
import '../../features/home/data/models/monthly_stats_model.dart';
import '../../features/home/data/models/public_message_model.dart';
import '../../features/home/data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // =====================
  // Collections
  // =====================
  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('habits');

  // =====================
  // Users
  // =====================

  Future<void> createUser(UserModel user) async {
    await _users.doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.id, doc.data()!);
  }

  Future<void> updateUser(UserModel user) async {
    await _users.doc(user.uid).update(user.toMap());
  }

  // get user by email

  Future<UserModel?> getUserByEmail(String email) async {
    final query = await _users
        .where('email', isEqualTo: email.trim().toLowerCase())
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return UserModel.fromMap(query.docs.first.id, query.docs.first.data());
  }

  // =====================
  // Monthly Stats
  // =====================

  Future<void> saveMonthlyStats(String uid, MonthlyStatsModel stats) async {
    await _users
        .doc(uid)
        .collection('stats')
        .doc(stats.month)
        .set(stats.toMap());
  }

  Future<MonthlyStatsModel?> getMonthlyStats(
    String uid,
    String month, // YYYY-MM
  ) async {
    final doc = await _users.doc(uid).collection('stats').doc(month).get();

    if (!doc.exists) return null;
    return MonthlyStatsModel.fromMap(doc.data()!);
  }

  // =====================
  // Groups
  // =====================

  Future<void> createGroup(GroupModel group) async {
    final docRef = _groups.doc();
    group = group.copyWith(id: docRef.id);

    await docRef
        .set(group.toMap())
        .timeout(
          Duration(seconds: 5),
          onTimeout: () => throw 'Connection timeout',
        );
  }

  Future<List<GroupModel>> getUserGroups(String uid) async {
    final query = await _groups
        .where('members', arrayContains: uid)
        .where('isActive', isEqualTo: true)
        .get();

    return query.docs.map((doc) => GroupModel.fromMap(doc.data())).toList();
  }

  Future<void> addMembers({
    required String groupId,
    required String userId,
  }) async {
    await _groups.doc(groupId).update({
      'members': FieldValue.arrayUnion([userId]),
    });

    await createDayIfNotExist(habitId: groupId, userId: userId);
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

    //  Delete messages
    final messages = await habitRef.collection('messages').get();
    for (var doc in messages.docs) {
      await doc.reference.delete();
    }

    //  Delete days + checkins
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
    final doc = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();

    if (doc.exists) {
      return GroupModel.fromMap(doc.data()!);
    } else {
      return null;
    }
  }

  // =====================
  // Check-ins
  // =====================

  Future<void> createDayIfNotExist({
    required String habitId,
    required String userId,
  }) async {
    final now = DateTime.now();
    final dayId = DateFormat('yyyy-MM-dd').format(now);

    final dayRef = _groups.doc(habitId).collection('days').doc(dayId);

    // Create day if it doesn't exist
    final daySnapshot = await dayRef.get();

    if (!daySnapshot.exists) {
      await dayRef.set({
        'day': dayId,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      final groupDoc = await _groups.doc(habitId).get();
      if (groupDoc.exists) {
        final members = List<String>.from(groupDoc.data()?['members'] ?? []);
        final batch = _firestore.batch();
        for (final memberId in members) {
          final checkInRef = dayRef.collection('checkins').doc(memberId);
          final checkIn = CheckInModel(
            userId: memberId,
            date: now.toIso8601String(),
            status: CheckInStatus.pending,
            createdAt: now,
          );
          batch.set(checkInRef, checkIn.toMap());
        }
        await batch.commit();
      }
    }

    // Ensure the current user has a check-in in case they joined after day creation
    final checkInRef = dayRef.collection('checkins').doc(userId);
    final checkInSnapshot = await checkInRef.get();

    if (!checkInSnapshot.exists) {
      final checkIn = CheckInModel(
        userId: userId,
        date: now.toIso8601String(),
        status: CheckInStatus.pending,
        createdAt: now,
      );
      await checkInRef.set(checkIn.toMap());
    }
  }

  // get day checkins

  Stream<List<CheckInModel>> getTodayCheckInsStream({
    required String habitId,
    required String date, // YYYY-MM-DD
  }) {
    return _groups
        .doc(habitId)
        .collection('days')
        .doc(date)
        .collection('checkins')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => CheckInModel.fromMap(doc.data()))
              .toList();
        });
  }
  // update status

  Future<void> updateCheckInStatus({
    required String habitId,
    required String date,
    required String userId,
    required CheckInStatus status,
  }) async {
    final checkInRef = _groups
        .doc(habitId)
        .collection('days')
        .doc(date)
        .collection('checkins')
        .doc(userId);

    await checkInRef.update({'status': status.name});
  }

  // update message

  Future<void> updateCheckInMessage({
    required String habitId,
    required String date,
    required String userId,
    required String message,
  }) async {
    final checkInRef = _groups
        .doc(habitId)
        .collection('days')
        .doc(date)
        .collection('checkins')
        .doc(userId);

    await checkInRef.update({'messagePublic': message});
  }

  // get all days (Stream)

  Stream<List<DayModel>> getAllDaysStream(String habitId) {
    return _groups
        .doc(habitId)
        .collection('days')
        .orderBy('day', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => DayModel.fromMap(doc.data())).toList(),
        );
  }

  // get all days (Future)

  Future<List<DayModel>> getAllDaysFuture(String habitId) async {
    final query = await _groups
        .doc(habitId)
        .collection('days')
        .orderBy('day', descending: true)
        .get();

    return query.docs.map((doc) => DayModel.fromMap(doc.data())).toList();
  }

  // get day checkins (Future)

  Future<List<CheckInModel>> getDayCheckInsFuture({
    required String habitId,
    required String date, // YYYY-MM-DD
  }) async {
    final query = await _groups
        .doc(habitId)
        .collection('days')
        .doc(date)
        .collection('checkins')
        .get();

    return query.docs.map((doc) => CheckInModel.fromMap(doc.data())).toList();
  }

  // =====================
  // Public Messages
  // =====================

  Future<void> addPublicMessage({
    required String habitId,
    required PublicMessageModel message,
  }) async {
    await _groups.doc(habitId).collection('messages').add(message.toMap());
  }

  Future<List<PublicMessageModel>> getMessages(String habitId) async {
    final query = await _groups
        .doc(habitId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs
        .map((doc) => PublicMessageModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  // =====================
  // Today Date
  // =====================

  Future<void> updateToday() async {
    await _firestore.collection('core').doc('date').set({
      'today': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getToday() async {
    var day = await _firestore.collection('core').doc('date').get();
    return day;
  }

  // =====================
  // Join Group
  // =====================

  Future<void> joinGroup({
    required String joinCode,
    required String password,
    required String userId,
  }) async {
    final query = await _firestore
        .collection('habits')
        .where('joinCode', isEqualTo: joinCode)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      throw Exception("Group not found");
    }

    final doc = query.docs.first;
    final data = doc.data();

    if (data['members'].contains(userId)) {
      throw Exception("You already joined this group");
    }

    final enteredHash = SecurityHelper.hashPassword(password);

    if (data['passwordHash'] != enteredHash) {
      throw Exception("Wrong password");
    }

    await doc.reference.update({
      'members': FieldValue.arrayUnion([userId]),
    });

    await createDayIfNotExist(habitId: doc.id, userId: userId);
  }

  Future<String> generateUniqueJoinCode() async {
    while (true) {
      final code = generateJoinCode();

      final existing = await _firestore
          .collection('habits')
          .where('joinCode', isEqualTo: code)
          .limit(1)
          .get();

      if (existing.docs.isEmpty) {
        return code;
      }
    }
  }

  // =====================
  //  Get Join Code
  // =====================

  Future<String?> getJoinCode(String habitId) async {
    final doc = await _groups.doc(habitId).get();

    if (!doc.exists) return null;

    return doc.data()?['joinCode'];
  }

  // remove member

  Future<void> removeMember({
    required String groupId,
    required String userId,
  }) async {
    await _groups.doc(groupId).update({
      'members': FieldValue.arrayRemove([userId]),
    });
  }

  // get all group members

  Future<List<UserModel>> getGroupMembers(String groupId) async {
    final doc = await _groups.doc(groupId).get();
    if (!doc.exists) return [];

    final List<String> memberIds = List<String>.from(
      doc.data()?['members'] ?? [],
    );

    final List<UserModel> members = [];

    for (var id in memberIds) {
      final user = await getUser(id);
      if (user != null) members.add(user);
    }

    return members;
  }
}
