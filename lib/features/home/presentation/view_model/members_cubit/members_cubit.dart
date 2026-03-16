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
      getAllMembers(groupId);
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

  // get group members

  Future<void> getAllMembers(String groupId) async {
    emit(MembersLoading());

    try {
      var members = await _firestoreService.getGroupMembers(groupId);

      emit(MembersLoaded(members: members));
    } catch (e) {
      emit(MembersError(errMassage: e.toString()));
    }
  }

  // get current user

  Future<UserModel?> getCurrentUser() async {
    UserModel? userModel;

    try {
      final userId = _firebaseAuthService.getCurrentUser()!.uid;
      userModel = await _firestoreService.getUser(userId);
      emit(MembersFound(user: userModel!));
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

  Future<void> getMemberByEmail(String email, String currentUserId) async {
    emit(MembersLoading());
    isLoading = true;

    try {
      final user = await _firestoreService.getUserByEmail(email);

      if (user == null) {
        emit(MembersError(errMassage: "No user found with this email"));
        return;
      }

      if (user.uid == currentUserId) {
        emit(MembersError(errMassage: "You can't add yourself"));
        return;
      }

      if (membersIds.contains(user.uid)) {
        emit(MembersError(errMassage: "User is already a member"));
        return;
      }

      emit(MembersFound(user: user));
    } on Exception catch (e) {
      emit(MembersError(errMassage: e.toString()));
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
    emit(MembersLoading());

    try {
      await _firestoreService.removeMember(
        groupId: groupId,
        userId: member.uid,
      );

      getAllMembers(groupId);
    } catch (e) {
      log(e.toString());
      emit(MembersError(errMassage: e.toString()));
    }
  }

  // add user by email

  Future<void> addMemberByEmail({
    required String groupId,
    required List<String> currentMembers, // from your loaded GroupModel
    required String email,
  }) async {
    emit(MembersLoading());

    try {
      // Find user
      final user = await _firestoreService.getUserByEmail(email);
      if (user == null) throw Exception("No user found with this email");

      // Check duplicate
      if (currentMembers.contains(user.uid)) {
        throw Exception("This user is already a member");
      }

      // Add
      await _firestoreService.addMembers(groupId: groupId, userId: user.uid);

      emit(MembersAdded());
    } on Exception catch (e) {
      emit(MembersError(errMassage: e.toString()));
    }
  }
}
