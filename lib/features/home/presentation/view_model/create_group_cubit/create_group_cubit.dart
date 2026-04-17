import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/security_helper.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit(this._firestoreService, this._user)
    : super(CreateGroupInitial());
  final FirestoreService _firestoreService;
  final User? _user;

  final groupNameController = TextEditingController();
  final groupPasswordController = TextEditingController();
  final memberEmailController = TextEditingController();
  final createGroupKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Future<void> close() {
    groupNameController.dispose();
    groupPasswordController.dispose();
    memberEmailController.dispose();
    return super.close();
  }

  // =====================
  // Create group
  // =====================

  Future<void> createGroup({
    required String title,
    required String password,
    List<UserModel>? invitedUsers,
  }) async {
    try {
      isLoading = true;
      if (!isClosed) emit(CreateGroupLoading());

      // Only the creator is an initial member
      final List<String> groupMembers = [_user!.uid];

      GroupModel habitModel = GroupModel(
        id: '',
        joinCode: await _firestoreService.generateUniqueJoinCode(),
        passwordHash: password.isNotEmpty
            ? SecurityHelper.hashPassword(password)
            : '',
        name: title,
        createdBy: _user.uid,
        members: groupMembers,
        isActive: true,
      );

      final createdGroup = await _firestoreService.createGroup(habitModel);

      // Send invitations to other users
      if (invitedUsers != null && invitedUsers.isNotEmpty) {
        final currentUserModel = await _firestoreService.getUser(_user.uid);
        final senderName = currentUserModel?.name ?? 'Unknown';

        for (var user in invitedUsers) {
          if (user.uid == _user.uid) continue; // Skip self if somehow included

          await _firestoreService.sendInvitation(
            groupId: createdGroup.id,
            groupName: createdGroup.name,
            senderId: _user.uid,
            senderName: senderName,
            receiverId: user.uid,
            receiverName: user.name,
            receiverEmail: user.email,
            groupImageUpdatedAt: createdGroup.imageUpdatedAt,
          );
        }
      }

      if (!isClosed) emit(CreateGroupSuccess());
      isLoading = false;
    } catch (e) {
      isLoading = false;
      if (!isClosed) emit(CreateGroupFaliure(errMessage: e.toString()));
      log(e.toString());
    }
  }
}
