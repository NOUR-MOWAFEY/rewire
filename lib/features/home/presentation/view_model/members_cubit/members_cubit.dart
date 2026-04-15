import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/data/models/invitation_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  MembersCubit([String? groupId]) : super(MembersInitial()) {
    // Check global cache for instant display
    final cachedUser = _firestoreService.currentUser;

    if (cachedUser != null) {
      members.add(cachedUser);
      _currentMembers = [cachedUser];
      _emitLoaded();
    }

    getCurrentUser().then((value) {
      if (value != null) {
        // Replace or add the fetched user
        members.removeWhere((u) => u.uid == value.uid);
        members.add(value);
        _currentMembers = members.toList();
        _emitLoaded();
      }
    });

    if (groupId != null) {
      listenToAllMembers(groupId);
    }
  }

  bool isLoading = false;

  final _firestoreService = getIt.get<FirestoreService>();

  final _firebaseAuthService = getIt.get<FirebaseAuthService>();

  final Set<UserModel> members = {};

  /// Cached current user ID — set once in [getCurrentUser] to avoid
  /// calling into FirebaseAuth on every widget build via [isCurrentUser].
  String? _currentUserId;

  List<UserModel> _currentMembers = [];
  List<InvitationModel> _currentInvitations = [];

  Set<String> get membersIds => members.map((e) => e.uid).toSet();

  StreamSubscription? _membersSubscription;
  StreamSubscription? _invitationsSubscription;

  // get group members

  void listenToAllMembers(String groupId) {
    if (!isClosed) emit(MembersLoading());

    _membersSubscription?.cancel();
    _invitationsSubscription?.cancel();

    _membersSubscription = _firestoreService
        .listenToGroupMembers(groupId)
        .listen(
          (streamedMembers) {
            _currentMembers = streamedMembers;
            members.clear();
            members.addAll(streamedMembers);
            _emitLoaded();
          },
          onError: (e) {
            if (!isClosed) emit(MembersError(errMassage: e.toString()));
          },
        );

    _invitationsSubscription = _firestoreService
        .listenToGroupInvitations(groupId)
        .listen(
          (invitations) {
            _currentInvitations = invitations;
            _emitLoaded();
          },
          onError: (e) {
            log('Invitations error: $e');
            _emitLoaded(); // Emit current members even if invitations fail
          },
        );
  }

  void _emitLoaded() {
    if (!isClosed) {
      emit(
        MembersLoaded(
          members: _currentMembers,
          pendingInvitations: _currentInvitations,
        ),
      );
    }
  }

  // get current user

  Future<UserModel?> getCurrentUser() async {
    UserModel? userModel;

    try {
      final userId = _firebaseAuthService.getCurrentUser()!.uid;
      _currentUserId = userId; // cache once
      userModel = await _firestoreService.getUser(userId);
      if (!isClosed) emit(MembersFound(user: userModel!));
    } catch (e) {
      log(e.toString());
    }

    return userModel;
  }

  // check if current user

  bool isCurrentUser(UserModel user) {
    // Use the cached id — avoids calling FirebaseAuth on every tile build
    if (_currentUserId != null) return _currentUserId == user.uid;
    try {
      return _firebaseAuthService.getCurrentUser()!.uid == user.uid;
    } catch (e) {
      return false;
    }
  }

  // get member by email

  Future<bool> getMemberByEmail(String email, String currentUserId) async {
    if (!isClosed) emit(MembersLoading());
    isLoading = true;

    try {
      final user = await _firestoreService.getUserByEmail(email);

      if (user == null) {
        if (!isClosed) {
          emit(MembersNotFound(errMessage: "No user found with this email"));
        }
        return false;
      }

      if (user.uid == currentUserId) {
        if (!isClosed) {
          emit(MembersNotFound(errMessage: "You can't add yourself"));
        }
        return false;
      }

      if (membersIds.contains(user.uid)) {
        if (!isClosed) {
          emit(MembersNotFound(errMessage: "User is already a member"));
        }
        return false;
      }

      if (!isClosed) emit(MembersFound(user: user));
      return true;
    } on Exception catch (e) {
      if (!isClosed) emit(MembersNotFound(errMessage: e.toString()));
      return false;
    } finally {
      isLoading = false;
    }
  }

  // remove member from list

  void removeMemberFromList(UserModel member) {
    members.remove(member);
    _emitLoaded();
  }

  // remove member from group

  Future<void> removeMemberFromGroup(String groupId, UserModel member) async {
    if (!isClosed) emit(MembersLoading());

    try {
      await _firestoreService.removeMember(
        groupId: groupId,
        userId: member.uid,
      );
    } catch (e) {
      log(e.toString());
      emit(MembersError(errMassage: e.toString()));
    }
  }

  // send invitation by email

  Future<void> sendInvitationByEmail({
    required String groupId,
    required String groupName,
    required String email,
  }) async {
    if (!isClosed) emit(MembersLoading());

    try {
      // Find user
      final user = await _firestoreService.getUserByEmail(email);

      if (user == null) throw "No user found with this email";

      // get current user for sender info
      final currentUser = await getCurrentUser();
      if (currentUser == null) throw "Authentication error";

      // get current members
      var currentMembers = await _firestoreService.getGroupMembers(groupId);

      // Check duplicate
      if (currentMembers.any((member) => user.uid == member.uid)) {
        throw "This user is already a member";
      }

      // Send Invitation
      await _firestoreService.sendInvitation(
        groupId: groupId,
        groupName: groupName,
        senderId: currentUser.uid,
        senderName: currentUser.name,
        receiverId: user.uid,
        receiverName: user.name,
        receiverEmail: user.email,
      );

      if (!isClosed) emit(MembersAdded());
    } catch (e) {
      if (!isClosed) emit(MembersError(errMassage: e.toString()));
    }
  }

  // cancel invitation

  Future<void> cancelInvitation(String invitationId) async {
    try {
      await _firestoreService.cancelInvitation(invitationId);
    } catch (e) {
      log('Cancel invitation error: $e');
    }
  }

  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    _invitationsSubscription?.cancel();
    return super.close();
  }
}
