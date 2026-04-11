import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/utils/code_generator.dart';
import 'package:rewire/core/utils/security_helper.dart';
import 'package:rewire/features/home/data/models/day_model.dart';

import '../../features/home/data/models/checkin_model.dart';
import '../../features/home/data/models/group_model.dart';
import '../../features/home/data/models/invitation_model.dart';
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
        .limit(7)
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
        .limit(7)
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
  // Invitations
  // =====================

  Future<void> sendInvitation({
    required String groupId,
    required String groupName,
    required String senderId,
    required String senderName,
    required String receiverId,
    required String receiverName,
    required String receiverEmail,
  }) async {
    // Check if invitation already exists
    final existing = await _firestore
        .collection('invitations')
        .where('groupId', isEqualTo: groupId)
        .where('receiverId', isEqualTo: receiverId)
        .where('status', isEqualTo: InvitationStatus.pending.name)
        .get();

    if (existing.docs.isNotEmpty) {
      throw 'An invitation is already pending for this user';
    }

    await _firestore.collection('invitations').add({
      'groupId': groupId,
      'groupName': groupName,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'receiverEmail': receiverEmail,
      'status': InvitationStatus.pending.name,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<InvitationModel>> listenToInvitations(String userId) {
    return _firestore
        .collection('invitations')
        .where('receiverId', isEqualTo: userId)
        .where('status', isEqualTo: InvitationStatus.pending.name)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => InvitationModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> respondToInvitation({
    required InvitationModel invitation,
    required bool accept,
  }) async {
    if (accept) {
      // Add to members array in group
      await _groups.doc(invitation.groupId).update({
        'members': FieldValue.arrayUnion([invitation.receiverId]),
      });

      // Initialize check-ins
      await createDayIfNotExist(
        habitId: invitation.groupId,
        userId: invitation.receiverId,
      );

      // Delete invitation record after processing
      await _firestore.collection('invitations').doc(invitation.id).delete();
    } else {
      // Delete invitation record after declining
      await _firestore.collection('invitations').doc(invitation.id).delete();
    }
  }

  Stream<List<InvitationModel>> listenToGroupInvitations(String groupId) {
    return _firestore
        .collection('invitations')
        .where('groupId', isEqualTo: groupId)
        .where('status', isEqualTo: InvitationStatus.pending.name)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => InvitationModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> cancelInvitation(String invitationId) async {
    await _firestore.collection('invitations').doc(invitationId).delete();
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
    final trimmedCode = joinCode.trim().toUpperCase();

    if (trimmedCode.length < 6 || trimmedCode.length > 6) {
      throw 'Group not found';
    }

    final query = await _firestore
        .collection('habits')
        .where('joinCode', isEqualTo: trimmedCode)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      throw ("Group not found");
    }

    final doc = query.docs.first;
    final data = doc.data();

    if (data['members'].contains(userId)) {
      throw ("You already joined this group");
    }

    final String storedHash = data['passwordHash'] ?? '';

    if (storedHash.isNotEmpty) {
      final enteredHash = SecurityHelper.hashPassword(password);

      if (storedHash != enteredHash) {
        throw ("Wrong password");
      }
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

  Future<void> leaveGroup({
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

  // listen to group members

  Stream<List<UserModel>> listenToGroupMembers(String groupId) {
    return _groups.doc(groupId).snapshots().asyncMap((doc) async {
      if (!doc.exists) return [];

      final List<String> memberIds = List<String>.from(
        doc.data()?['members'] ?? [],
      );

      // Fetch all users in parallel with a safety timeout per fetch
      final userModels = await Future.wait(
        memberIds.map(
          (id) => getUser(id).timeout(
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
