import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/data/models/habit_model.dart';
import 'package:rewire/features/home/data/models/monthly_stats_model.dart';
import 'package:rewire/features/home/data/models/public_message_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

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

  Future<void> createHabit(HabitModel habit) async {
    await _habits.doc().set(habit.toMap());
  }

  Future<List<HabitModel>> getUserHabits(String uid) async {
    final query = await _habits
        .where('participants', arrayContains: uid)
        .where('isActive', isEqualTo: true)
        .get();

    return query.docs.map((doc) => HabitModel.fromMap(doc.data())).toList();
  }

  Future<void> addParticipant({
    required String habitId,
    required String userId,
  }) async {
    await _habits.doc(habitId).update({
      'participants': FieldValue.arrayUnion([userId]),
    });
  }

  Stream<List<HabitModel>> listenToHabits(String userId) {
    return _habits
        .where('participants', arrayContains: userId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((e) => HabitModel.fromMap(e.data())).toList(),
        );
  }

  // =====================
  // Check-ins
  // =====================

  Future<void> addCheckIn({
    required String habitId,
    required CheckInModel checkIn,
  }) async {
    final docId = '${checkIn.date}_${checkIn.userId}';

    await _habits
        .doc(habitId)
        .collection('checkins')
        .doc(docId)
        .set(checkIn.toMap());
  }

  Future<List<CheckInModel>> getTodayCheckIns({
    required String habitId,
    required String date, // YYYY-MM-DD
  }) async {
    final query = await _habits
        .doc(habitId)
        .collection('checkins')
        .where('date', isEqualTo: date)
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
}
