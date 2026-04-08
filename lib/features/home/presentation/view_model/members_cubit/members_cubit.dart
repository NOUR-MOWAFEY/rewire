import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  MembersCubit([String? groupId]) : super(MembersInitial()) {
    getCurrentUser().then((value) => members.add(value!));

    if (groupId != null) {
      listenToAllMembers(groupId);
    }
  }

  bool isLoading = false;

  final _firestoreService = getIt.get<FirestoreService>();

  final _firebaseAuthService = getIt.get<FirebaseAuthService>();

  final Set<String> membersIds = {};

  final Set<UserModel> members = {};

  // convert list of ids to usermodels

  // Future<void> getUsersFromIds(List<String> ids) async {
  //   emit(MembersLoading());

  //   List<UserModel> users = [];

  //   try {
  //     for (var id in ids) {
  //       try {
  //         await _firestoreService
  //             .getUser(id)
  //             .then((value) => users.add(value!));
  //       } catch (e) {
  //         log(e.toString());
  //       }
  //     }

  //     members.addAll(users);

  //     emit(MembersLoaded(members: members.toList()));
  //   } catch (e) {
  //     emit(MembersError(errMassage: e.toString()));
  //   }
  // }

  StreamSubscription? _membersSubscription;

  // get group members

  void listenToAllMembers(String groupId) {
    if (!isClosed) emit(MembersLoading());

    _membersSubscription?.cancel();
    _membersSubscription = _firestoreService
        .listenToGroupMembers(groupId)
        .listen(
          (streamedMembers) {
            members.clear();
            membersIds.clear();
            
            members.addAll(streamedMembers);
            membersIds.addAll(streamedMembers.map((e) => e.uid));
            
            if (!isClosed) emit(MembersLoaded(members: streamedMembers));
          },
          onError: (e) {
            if (!isClosed) emit(MembersError(errMassage: e.toString()));
          },
        );
  }

  // get current user

  Future<UserModel?> getCurrentUser() async {
    UserModel? userModel;

    try {
      final userId = _firebaseAuthService.getCurrentUser()!.uid;
      userModel = await _firestoreService.getUser(userId);
      if (!isClosed) emit(MembersFound(user: userModel!));
    } catch (e) {
      log(e.toString());
    }

    return userModel;
  }

  // check if current user

  bool isCurrentUser(UserModel user) {
    try {
      final userId = _firebaseAuthService.getCurrentUser()!.uid;

      if (userId == user.uid) {
        return true;
      }
    } catch (e) {
      e.toString();
    }

    return false;
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
    membersIds.remove(member.uid);
    emit(MembersRemoved());
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

  // add user by email

  Future<void> addMemberByEmail({
    required String groupId,
    required String email,
  }) async {
    if (!isClosed) emit(MembersLoading());

    try {
      // Find user
      final user = await _firestoreService.getUserByEmail(email);

      if (user == null) throw "No user found with this email";

      // get current members

      var currentMembers = await _firestoreService.getGroupMembers(groupId);

      log(currentMembers.toString());

      // Check duplicate
      if (currentMembers.any((member) => user.uid == member.uid)) {
        throw "This user is already a member";
      }

      // Add
      await _firestoreService.addMembers(groupId: groupId, userId: user.uid);

      if (!isClosed) emit(MembersAdded());
    } catch (e) {
      if (!isClosed) emit(MembersError(errMassage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    return super.close();
  }
}
