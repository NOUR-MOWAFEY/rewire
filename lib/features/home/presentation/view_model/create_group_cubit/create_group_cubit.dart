import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/security_helper.dart';
import 'package:rewire/features/home/data/models/group_model.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit(this._firestoreService, this._user)
    : super(CreateGroupInitial());
  final FirestoreService _firestoreService;
  final User? _user;

  bool isLoading = false;

  // =====================
  // Create group
  // =====================

  Future<void> createGroup({
    required String title,
    required String password,
    List<String>? members,
  }) async {
    try {
      isLoading = true;
      if (!isClosed) emit(CreateGroupLoading());

      final List<String> groupMembers = [_user!.uid];

      if (members != null && members.isNotEmpty) {
        groupMembers.addAll(members);
      }

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
      await _firestoreService.createGroup(habitModel);
      if (!isClosed) emit(CreateGroupSuccess());
      isLoading = false;
    } catch (e) {
      isLoading = false;
      if (!isClosed) emit(CreateGroupFaliure(errMessage: e.toString()));
      log(e.toString());
    }
  }
}
