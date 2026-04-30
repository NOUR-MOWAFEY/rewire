import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rewire/features/group/data/models/checkin_model.dart';
import 'package:rewire/features/group/data/models/day_model.dart';
import 'package:rewire/features/group/data/models/group_model.dart';
import 'package:rewire/features/group/data/models/public_message_model.dart';
import 'package:rewire/features/invitations/data/models/invitation_model.dart';
import 'package:rewire/features/profile_view/data/models/user_model.dart';

import 'checkin_firestore_service.dart';
import 'core_firestore_service.dart';
import 'group_firestore_service.dart';
import 'group_membership_firestore_service.dart';
import 'invitation_firestore_service.dart';
import 'message_firestore_service.dart';
import 'user_firestore_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final UserFirestoreService _userService;
  late final GroupFirestoreService _groupService;
  late final GroupMembershipFirestoreService _membershipService;
  late final CheckinFirestoreService _checkinService;
  late final MessageFirestoreService _messageService;
  late final InvitationFirestoreService _invitationService;
  late final CoreFirestoreService _coreService;

  FirestoreService() {
    _userService = UserFirestoreService(_firestore);
    _checkinService = CheckinFirestoreService(_firestore);
    _groupService = GroupFirestoreService(_firestore, _checkinService);
    _membershipService = GroupMembershipFirestoreService(
      _firestore,
      _checkinService,
      _userService,
    );
    _invitationService = InvitationFirestoreService(_firestore, _checkinService);
    _messageService = MessageFirestoreService(_firestore);
    _coreService = CoreFirestoreService(_firestore);
  }

  // =====================
  // Cache
  // =====================

  UserModel? get currentUser => _userService.currentUser;

  void clearCache() => _userService.clearCache();

  // =====================
  // Users
  // =====================

  Future<void> createUser(UserModel user) => _userService.createUser(user);

  Future<UserModel?> getUser(String uid) => _userService.getUser(uid);

  Future<void> updateUser(UserModel user) => _userService.updateUser(user);

  Future<UserModel?> getUserByEmail(String email) =>
      _userService.getUserByEmail(email);

  Stream<UserModel?> listenToUser(String userId) =>
      _userService.listenToUser(userId);

  // =====================
  // Groups
  // =====================

  Future<GroupModel> createGroup(GroupModel group) =>
      _groupService.createGroup(group);

  Future<List<GroupModel>> getUserGroups(String uid) =>
      _groupService.getUserGroups(uid);

  List<GroupModel> filterGroupsWithLeaderboard(List<GroupModel> groups) =>
      _groupService.filterGroupsWithLeaderboard(groups);

  Future<void> addMembers({
    required String groupId,
    required String userId,
  }) => _groupService.addMembers(groupId: groupId, userId: userId);

  Stream<List<GroupModel>> listenToGroups(String userId) =>
      _groupService.listenToGroups(userId);

  Future<void> deleteGroup(String habitId) =>
      _groupService.deleteGroup(habitId);

  Future<void> updateGroup({
    required String groupId,
    required String? newName,
    required String? newPassword,
  }) => _groupService.updateGroup(
        groupId: groupId,
        newName: newName,
        newPassword: newPassword,
      );

  Future<GroupModel?> getGroupById(String groupId) =>
      _groupService.getGroupById(groupId);

  // =====================
  // Group Membership
  // =====================

  Future<void> joinGroup({
    required String joinCode,
    required String password,
    required String userId,
  }) => _membershipService.joinGroup(
        joinCode: joinCode,
        password: password,
        userId: userId,
      );

  Future<void> joinGroupViaId({
    required String groupId,
    required String userId,
  }) => _membershipService.joinGroupViaId(groupId: groupId, userId: userId);

  Future<String> generateUniqueJoinCode() =>
      _membershipService.generateUniqueJoinCode();

  Future<String?> getJoinCode(String habitId) =>
      _membershipService.getJoinCode(habitId);

  Future<void> removeMember({
    required String groupId,
    required String userId,
  }) => _membershipService.removeMember(groupId: groupId, userId: userId);

  Future<void> leaveGroup({
    required String groupId,
    required String userId,
  }) => _membershipService.leaveGroup(groupId: groupId, userId: userId);

  Future<List<UserModel>> getGroupMembers(String groupId) =>
      _membershipService.getGroupMembers(groupId);

  Stream<List<UserModel>> listenToGroupMembers(String groupId) =>
      _membershipService.listenToGroupMembers(groupId);

  // =====================
  // Check-ins
  // =====================

  Future<void> fillMissingDays({required String habitId}) =>
      _checkinService.fillMissingDays(habitId: habitId);

  Future<void> createDayIfNotExist({
    required String habitId,
    required String userId,
  }) => _checkinService.createDayIfNotExist(habitId: habitId, userId: userId);

  Stream<List<CheckInModel>> getTodayCheckInsStream({
    required String habitId,
    required String date,
  }) => _checkinService.getTodayCheckInsStream(habitId: habitId, date: date);

  Future<void> updateCheckInStatus({
    required String habitId,
    required String date,
    required String userId,
    required CheckInStatus status,
  }) => _checkinService.updateCheckInStatus(
        habitId: habitId,
        date: date,
        userId: userId,
        status: status,
      );

  Future<void> updateCheckInMessage({
    required String habitId,
    required String date,
    required String userId,
    required String message,
  }) => _checkinService.updateCheckInMessage(
        habitId: habitId,
        date: date,
        userId: userId,
        message: message,
      );

  Stream<List<DayModel>> getAllDaysStream(String habitId) =>
      _checkinService.getAllDaysStream(habitId);

  Future<List<DayModel>> getAllDaysFuture(String habitId) =>
      _checkinService.getAllDaysFuture(habitId);

  Future<List<CheckInModel>> getDayCheckInsFuture({
    required String habitId,
    required String date,
  }) => _checkinService.getDayCheckInsFuture(habitId: habitId, date: date);

  // =====================
  // Public Messages
  // =====================

  Future<void> addPublicMessage({
    required String habitId,
    required PublicMessageModel message,
  }) => _messageService.addPublicMessage(habitId: habitId, message: message);

  Future<List<PublicMessageModel>> getMessages(String habitId) =>
      _messageService.getMessages(habitId);

  // =====================
  // Invitations
  // =====================

  Future<void> sendInvitation(InvitationModel invitation) =>
      _invitationService.sendInvitation(invitation);

  Stream<List<InvitationModel>> listenToInvitations(String userId) =>
      _invitationService.listenToInvitations(userId);

  Future<void> respondToInvitation({
    required InvitationModel invitation,
    required bool accept,
  }) => _invitationService.respondToInvitation(
        invitation: invitation,
        accept: accept,
      );

  Stream<List<InvitationModel>> listenToGroupInvitations(String groupId) =>
      _invitationService.listenToGroupInvitations(groupId);

  Future<void> cancelInvitation(String invitationId) =>
      _invitationService.cancelInvitation(invitationId);

  // =====================
  // Today Date
  // =====================

  Future<void> updateToday() => _coreService.updateToday();

  Future<DocumentSnapshot<Map<String, dynamic>>> getToday() =>
      _coreService.getToday();
}
