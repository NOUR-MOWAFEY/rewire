import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rewire/features/group/data/models/checkin_model.dart';
import 'package:rewire/features/group/data/models/day_model.dart';

class CheckinFirestoreService {
  final FirebaseFirestore _firestore;

  CheckinFirestoreService(this._firestore);

  // =====================
  // Collections
  // =====================

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('habits');

  // =====================
  // Check-ins
  // =====================

  Future<void> fillMissingDays({required String habitId}) async {
    final query = await _groups
        .doc(habitId)
        .collection('days')
        .orderBy('day', descending: true)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return;

    final lastDayStr = query.docs.first.id;
    final lastDayDate = DateFormat('yyyy-MM-dd').parse(lastDayStr);
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);

    if (!lastDayDate.isBefore(todayDate)) return;

    final groupDoc = await _groups.doc(habitId).get();
    if (!groupDoc.exists) return;

    final members = List<String>.from(groupDoc.data()?['members'] ?? []);

    var batch = _firestore.batch();
    int batchCount = 0;

    DateTime currentDate = lastDayDate.add(const Duration(days: 1));

    while (currentDate.isBefore(todayDate)) {
      final dateStr = DateFormat('yyyy-MM-dd').format(currentDate);
      final dayRef = _groups.doc(habitId).collection('days').doc(dateStr);

      final daySnapshot = await dayRef.get();
      if (!daySnapshot.exists) {
        batch.set(dayRef, {
          'day': dateStr,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        batchCount++;

        for (final memberId in members) {
          final checkInRef = dayRef.collection('checkins').doc(memberId);
          final checkIn = CheckInModel(
            userId: memberId,
            groupId: habitId,
            date: currentDate.toIso8601String(),
            status: CheckInStatus.pending,
            createdAt: currentDate,
          );
          batch.set(checkInRef, checkIn.toMap());
          batchCount++;

          if (batchCount >= 400) {
            await batch.commit();
            batch = _firestore.batch();
            batchCount = 0;
          }
        }
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    if (batchCount > 0) {
      await batch.commit();
    }
  }

  Future<void> createDayIfNotExist({
    required String habitId,
    required String userId,
  }) async {
    final now = DateTime.now();
    final dayId = DateFormat('yyyy-MM-dd').format(now);

    final dayRef = _groups.doc(habitId).collection('days').doc(dayId);

    // Fetch day doc and group doc in parallel
    final results = await Future.wait([
      dayRef.get(),
      _groups.doc(habitId).get(),
    ]);
    final daySnapshot = results[0];
    final groupDoc = results[1];

    if (!groupDoc.exists) return;
    final members = List<String>.from(groupDoc.data()?['members'] ?? []);

    final batch = _firestore.batch();
    bool hasChanges = false;

    if (!daySnapshot.exists) {
      // Create the day document
      batch.set(dayRef, {
        'day': dayId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Create check-ins for all members
      for (final memberId in members) {
        final checkInRef = dayRef.collection('checkins').doc(memberId);
        final checkIn = CheckInModel(
          userId: memberId,
          groupId: habitId,
          date: now.toIso8601String(),
          status: CheckInStatus.pending,
          createdAt: now,
        );
        batch.set(checkInRef, checkIn.toMap());
      }
      hasChanges = true;
    } else {
      // Day exists — ensure ALL members have a check-in
      final checkInsSnapshot = await dayRef.collection('checkins').get();
      final existingCheckInIds = checkInsSnapshot.docs
          .map((doc) => doc.id)
          .toSet();

      for (final memberId in members) {
        if (!existingCheckInIds.contains(memberId)) {
          final checkInRef = dayRef.collection('checkins').doc(memberId);
          final checkIn = CheckInModel(
            userId: memberId,
            groupId: habitId,
            date: now.toIso8601String(),
            status: CheckInStatus.pending,
            createdAt: now,
          );
          batch.set(checkInRef, checkIn.toMap());
          hasChanges = true;
        }
      }
    }

    if (hasChanges) {
      await batch.commit();
    }
  }

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
    // Recalculate member commitment score / percentage
    await _recalculateCommitmentPercentage(habitId, userId);
  }

  Future<void> _recalculateCommitmentPercentage(
    String habitId,
    String userId,
  ) async {
    final days = await _groups.doc(habitId).collection('days').get();

    int successCount = 0;
    int totalDays = days.docs.length;

    if (totalDays == 0) return;

    for (var dayDoc in days.docs) {
      final checkInDoc = await dayDoc.reference
          .collection('checkins')
          .doc(userId)
          .get();
      if (checkInDoc.exists) {
        if (checkInDoc.data()?['status'] == CheckInStatus.success.name) {
          successCount++;
        }
      }
    }

    num points = successCount * 10;

    await _groups.doc(habitId).update({'memberCommitments.$userId': points});
  }

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

  Stream<List<DayModel>> getAllDaysStream(String habitId) {
    return _groups
        .doc(habitId)
        .collection('days')
        .orderBy('day', descending: true)
        .limit(7)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => DayModel.fromMap(doc.data())).toList(),
        );
  }

  Future<List<DayModel>> getAllDaysFuture(String habitId) async {
    final query = await _groups
        .doc(habitId)
        .collection('days')
        .orderBy('day', descending: true)
        .limit(7)
        .get();

    return query.docs.map((doc) => DayModel.fromMap(doc.data())).toList();
  }

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
}
