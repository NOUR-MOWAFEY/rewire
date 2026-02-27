import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/shared_preferences_service.dart';
import 'package:rewire/core/utils/security_helper.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

import '../../../../../core/services/firestore_service.dart';
import '../../../data/models/group_model.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(this._firestoreService, this.user) : super(GroupInitial()) {
    log('Group Cubit Created');
    listenToGroups(user!.uid);
    isNewDay();
  }

  bool? isLoading = false;
  UserModel? userModel;
  final FirestoreService _firestoreService;
  User? user;
  StreamSubscription? _subscription;

  // =====================
  // Date Check
  // =====================

  Future<bool> isNewDay() async {
    final storage = getIt.get<SharedPreferencesService>();

    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    final storedDate = storage.getStoredDate();

    if (storedDate == null) {
      await storage.setTodayDate();
      return true;
    }

    log(normalizedToday.isAfter(storedDate).toString());

    if (normalizedToday.isAfter(storedDate)) {
      await storage.setTodayDate();

      return true;
    }
    return false;
  }

  // =====================
  // Listen to groups
  // =====================

  void listenToGroups(String userId) async {
    await getUserData()?.then((value) => userModel = value);
    _subscription = _firestoreService.listenToGroups(userId).listen((groups) {
      if (!isClosed) emit(GroupSuccess(groups: groups));
    });
  }

  // get user data
  Future<UserModel?>? getUserData() async {
    var data = await _firestoreService.getUser(user!.uid);
    return data;
  }

  @override
  Future<void> close() {
    log('Group Cubit Closed');
    _subscription?.cancel();
    return super.close();
  }

  // Edit Group Data

  Future<void> updateGroupData(
    String groupId,
    String newName,
    String newPassword,
  ) async {
    emit(GroupUpdateLoading());

    try {
      await _firestoreService.updateGroup(
        groupId: groupId,
        newName: newName,
        newPassword: SecurityHelper.hashPassword(newPassword),
      );

      emit(GroupUpdateSuccess());
    } catch (e) {
      log(e.toString());
      emit(GroupUpdateFailure(errMessage: e.toString()));
    }
  }
}
