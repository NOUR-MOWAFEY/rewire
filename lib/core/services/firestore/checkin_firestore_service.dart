import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rewire/features/group/data/models/checkin_model.dart';
import 'package:rewire/features/group/data/models/day_model.dart';

class CheckinFirestoreService {
  final FirebaseFirestore _firestore;

  static const int _batchLimit = 400;

  CheckinFirestoreService(this._firestore);

  // =====================
  // Collections
  // =====================

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('groups');

  // =====================
  // Private Helpers
  // =====================

  /// Shared query for the last 7 days of a group — avoids duplication
  Query<Map<String, dynamic>> _lastSevenDaysQuery(String groupId) => _groups
      .doc(groupId)
      .collection('days')
      .orderBy('day', descending: true)
      .limit(7);

  /// Creates a [CheckInModel] with [CheckInStatus.pending] for a member.
  CheckInModel _buildPendingCheckIn({
    required String memberId,
    required String groupId,
    required DateTime date,
  }) {
    return CheckInModel(
      userId: memberId,
      groupId: groupId,
      date: DateFormat('yyyy-MM-dd').format(date), // consistent YYYY-MM-DD
      status: CheckInStatus.pending,
      createdAt: date,
    );
  }

  // =====================
  // Check-ins
  // =====================

  /// Fills missing day documents (and their check-ins) between the last
  /// recorded day and today. Skips today — handled by [createDayIfNotExist].
  Future<void> fillMissingDays({required String groupId}) async {
    final query = await _groups
        .doc(groupId)
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

    final groupDoc = await _groups.doc(groupId).get();
    if (!groupDoc.exists) return;

    final members = List<String>.from(groupDoc.data()?['members'] ?? []);

    // Collect all dates that need to be filled
    final missingDates = <DateTime>[];
    DateTime cursor = lastDayDate.add(const Duration(days: 1));
    while (cursor.isBefore(todayDate)) {
      missingDates.add(cursor);
      cursor = cursor.add(const Duration(days: 1));
    }

    if (missingDates.isEmpty) return;

    // Fetch all day docs in parallel instead of sequentially
    final dayRefs = missingDates.map((date) {
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      return _groups.doc(groupId).collection('days').doc(dateStr);
    }).toList();

    final daySnapshots = await Future.wait(dayRefs.map((ref) => ref.get()));

    var batch = _firestore.batch();
    int batchCount = 0;

    for (int i = 0; i < missingDates.length; i++) {
      if (daySnapshots[i].exists) continue;

      final date = missingDates[i];
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      final dayRef = dayRefs[i];

      batch.set(dayRef, {
        'day': dateStr,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      batchCount++;

      for (final memberId in members) {
        final checkInRef = dayRef.collection('checkins').doc(memberId);
        batch.set(
          checkInRef,
          _buildPendingCheckIn(
            memberId: memberId,
            groupId: groupId,
            date: date,
          ).toMap(),
        );
        batchCount++;

        if (batchCount >= _batchLimit) {
          await batch.commit();
          batch = _firestore.batch();
          batchCount = 0;
        }
      }
    }

    if (batchCount > 0) {
      await batch.commit();
    }
  }

  /// Creates today's day document and check-ins for all members if missing.
  /// Uses merge on the day doc to avoid race conditions between concurrent calls.
  Future<void> createDayIfNotExist({
    required String groupId,
    required String userId,
  }) async {
    final now = DateTime.now();
    final dayId = DateFormat('yyyy-MM-dd').format(now);

    final dayRef = _groups.doc(groupId).collection('days').doc(dayId);

    // Fetch day doc and group doc in parallel
    final results = await Future.wait([
      dayRef.get(),
      _groups.doc(groupId).get(),
    ]);
    final daySnapshot = results[0];
    final groupDoc = results[1];

    if (!groupDoc.exists) return;
    final members = List<String>.from(groupDoc.data()?['members'] ?? []);

    final batch = _firestore.batch();
    bool hasChanges = false;

    // SetOptions(merge: true) makes day creation idempotent — safe under races
    batch.set(dayRef, {
      'day': dayId,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    if (!daySnapshot.exists) {
      // Brand-new day: create check-ins for every member
      for (final memberId in members) {
        final checkInRef = dayRef.collection('checkins').doc(memberId);
        batch.set(
          checkInRef,
          _buildPendingCheckIn(
            memberId: memberId,
            groupId: groupId,
            date: now,
          ).toMap(),
        );
      }
      hasChanges = true;
    } else {
      // Day exists — ensure every member has a check-in (handles new joiners)
      final checkInsSnapshot = await dayRef.collection('checkins').get();
      final existingIds = checkInsSnapshot.docs.map((doc) => doc.id).toSet();

      for (final memberId in members) {
        if (!existingIds.contains(memberId)) {
          final checkInRef = dayRef.collection('checkins').doc(memberId);
          batch.set(
            checkInRef,
            _buildPendingCheckIn(
              memberId: memberId,
              groupId: groupId,
              date: now,
            ).toMap(),
          );
          hasChanges = true;
        }
      }
    }

    if (hasChanges) {
      await batch.commit();
    }
  }

  Stream<List<CheckInModel>> getTodayCheckInsStream({
    required String groupId,
    required String date, // YYYY-MM-DD
  }) {
    return _groups
        .doc(groupId)
        .collection('days')
        .doc(date)
        .collection('checkins')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CheckInModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> updateCheckInStatus({
    required String groupId,
    required String date,
    required String userId,
    required CheckInStatus status,
  }) async {
    final checkInRef = _groups
        .doc(groupId)
        .collection('days')
        .doc(date)
        .collection('checkins')
        .doc(userId);

    await checkInRef.update({'status': status.name});
    await _recalculatePoints(groupId, userId);
  }

  /// Recalculates the total commitment points for [userId] in [groupId].
  /// Each successful check-in is worth 10 points.
  /// Runs all check-in fetches in parallel to avoid N+1 sequential reads.
  Future<void> _recalculatePoints(String groupId, String userId) async {
    final days = await _groups.doc(groupId).collection('days').get();

    if (days.docs.isEmpty) return;

    // Fetch all check-ins for this user in parallel (fixes N+1 problem)
    final checkInFutures = days.docs.map(
      (dayDoc) => dayDoc.reference.collection('checkins').doc(userId).get(),
    );
    final checkIns = await Future.wait(checkInFutures);

    final successCount = checkIns
        .where(
          (doc) =>
              doc.exists && doc.data()?['status'] == CheckInStatus.success.name,
        )
        .length;

    // 10 points per successful check-in
    final points = successCount * 10;

    await _groups.doc(groupId).update({'memberCommitments.$userId': points});
  }

  Future<void> updateCheckInMessage({
    required String groupId,
    required String date,
    required String userId,
    required String message,
  }) async {
    final checkInRef = _groups
        .doc(groupId)
        .collection('days')
        .doc(date)
        .collection('checkins')
        .doc(userId);

    await checkInRef.update({'messagePublic': message});
  }

  Stream<List<DayModel>> getAllDaysStream(String groupId) {
    return _lastSevenDaysQuery(groupId).snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => DayModel.fromMap(doc.data())).toList(),
    );
  }

  Future<List<DayModel>> getAllDaysFuture(String groupId) async {
    final query = await _lastSevenDaysQuery(groupId).get();
    return query.docs.map((doc) => DayModel.fromMap(doc.data())).toList();
  }

  Future<List<CheckInModel>> getDayCheckInsFuture({
    required String groupId,
    required String date, // YYYY-MM-DD
  }) async {
    final query = await _groups
        .doc(groupId)
        .collection('days')
        .doc(date)
        .collection('checkins')
        .get();

    return query.docs.map((doc) => CheckInModel.fromMap(doc.data())).toList();
  }
}
