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

  CollectionReference<Map<String, dynamic>> get _habits =>
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
  // Habits
  // =====================

  Future<void> createHabit(GroupModel habit) async {
    final docRef = _habits.doc();
    habit = habit.copyWith(id: docRef.id);

    await docRef
        .set(
          habit
              .copyWith(
                passwordHash: SecurityHelper.hashPassword(habit.passwordHash),
              )
              .toMap(),
        )
        .timeout(
          Duration(seconds: 5),
          onTimeout: () => throw 'Connection timeout',
        );
  }

  Future<List<GroupModel>> getUserHabits(String uid) async {
    final query = await _habits
        .where('participants', arrayContains: uid)
        .where('isActive', isEqualTo: true)
        .get();

    return query.docs.map((doc) => GroupModel.fromMap(doc.data())).toList();
  }

  Future<void> addParticipant({
    required String habitId,
    required String userId,
  }) async {
    await _habits.doc(habitId).update({
      'participants': FieldValue.arrayUnion([userId]),
    });
  }

  Stream<List<GroupModel>> listenToHabits(String userId) {
    return _habits
        .where('participants', arrayContains: userId)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((e) => GroupModel.fromMap(e.data())).toList(),
        );
  }

  Future<void> deleteGroup(String habitId) async {
    final habitRef = _habits.doc(habitId);

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

  // =====================
  // Check-ins
  // =====================
  Future<void> addCheckIn({
    required String habitId,
    required CheckInModel checkIn,
  }) async {
    final dayId = DateFormat('yyyy-MM-dd').format(checkIn.createdAt);

    final dayRef = _habits.doc(habitId).collection('days').doc(dayId);

    // Create day if it doesn't exist
    final daySnapshot = await dayRef.get();

    if (!daySnapshot.exists) {
      await dayRef.set({
        'day': dayId,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    // Now handle user check-in separately
    final checkInRef = dayRef.collection('checkins').doc(checkIn.userId);

    final checkInSnapshot = await checkInRef.get();

    if (checkInSnapshot.exists) {
      // user already checked in today
      return;
    }

    await checkInRef.set(checkIn.toMap());
  }

  Future<List<CheckInModel>> getTodayCheckIns({
    required String habitId,
    required String date, // YYYY-MM-DD
  }) async {
    final query = await _habits
        .doc(habitId)
        .collection('days')
        .doc(date)
        .collection('checkins')
        .get();

    return query.docs.map((doc) => CheckInModel.fromMap(doc.data())).toList();
  }

  Stream<List<DayModel>> getAllDaysStream(String habitId) {
    return _habits
        .doc(habitId)
        .collection('days')
        .orderBy('day', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => DayModel.fromMap(doc.data())).toList(),
        );
  }

  // =====================
  // Public Messages
  // =====================

  Future<void> addPublicMessage({
    required String habitId,
    required PublicMessageModel message,
  }) async {
    await _habits.doc(habitId).collection('messages').add(message.toMap());
  }

  Future<List<PublicMessageModel>> getMessages(String habitId) async {
    final query = await _habits
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

    if (data['participants'].contains(userId)) {
      throw Exception("You already joined this group");
    }

    final enteredHash = SecurityHelper.hashPassword(password);

    if (data['passwordHash'] != enteredHash) {
      throw Exception("Wrong password");
    }

    await doc.reference.update({
      'participants': FieldValue.arrayUnion([userId]),
    });
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
    final doc = await _habits.doc(habitId).get();

    if (!doc.exists) return null;

    return doc.data()?['joinCode'];
  }
}
