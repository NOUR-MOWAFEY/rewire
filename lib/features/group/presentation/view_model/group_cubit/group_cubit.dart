import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore/firestore_service.dart';

import '../../../../../core/services/shared_preferences_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/models/checkin_model.dart';
import '../../../data/models/day_model.dart';
import '../../../data/models/group_model.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(this._firestoreService) : super(GroupInitial()) {
    log('Group Cubit Created');
    isNewDay();
  }

  // Caching
  final Map<String, List<DayModel>> daysCache = {};
  final Map<String, Map<String, List<CheckInModel>>> checkinsCache = {};

  void cacheDays(String groupId, List<DayModel> days) {
    daysCache[groupId] = days;
  }

  void cacheCheckins(String groupId, String date, List<CheckInModel> checkins) {
    checkinsCache[groupId] ??= {};
    checkinsCache[groupId]![date] = checkins;
  }

  void clearCache() {
    daysCache.clear();
    checkinsCache.clear();
  }

  bool isLoading = false;
  final FirestoreService _firestoreService;
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
    if (!isClosed) emit(GroupLoading());

    _subscription?.cancel();
    _subscription = _firestoreService.listenToGroups(userId).listen((groups) {
      if (!isClosed) emit(GroupSuccess(groups: groups));
    });
  }

  // get group data

  Future<GroupModel?>? getGroupData(String groupId) async {
    try {
      final data = await _firestoreService.getGroupById(groupId);
      return data;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<void> close() {
    log('Group Cubit Closed');
    _subscription?.cancel();
    return super.close();
  }

  // Update Group Data

  Future<void> updateGroupData(
    String groupId,
    String? newName,
    String? newPassword,
  ) async {
    isLoading = true;
    if (!isClosed) emit(GroupUpdateLoading());

    try {
      await _firestoreService.updateGroup(
        groupId: groupId,
        newName: newName,
        newPassword: newPassword,
      );

      if (!isClosed) emit(GroupUpdateSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(GroupUpdateFailure(errMessage: e.toString()));
    } finally {
      isLoading = false;
    }
  }

  // add members

  Future<void> addMember(String groupId, String userId) async {
    if (!isClosed) emit(GroupAddMemberLoading());

    try {
      await _firestoreService.addMembers(groupId: groupId, userId: userId);
      if (!isClosed) emit(GroupAddMemberSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(GroupAddMemberFailure(errMessage: e.toString()));
    }
  }

  // leave group

  Future<void> leaveGroup(GroupModel groupModel) async {
    if (!isClosed) emit(GroupLeaveLoading());

    try {
      final userId = _firestoreService.currentUser!.uid;

      if (groupModel.createdBy == userId) {
        await _firestoreService.deleteGroup(groupModel.id);
      } else {
        await _firestoreService.leaveGroup(
          groupId: groupModel.id,
          userId: userId,
        );
      }
      if (!isClosed) emit(GroupLeaveSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(GroupLeaveFailure(errMessage: e.toString()));
    }
  }

  // get Join code

  Future<void> getJoinCode(String habitId) async {
    if (!isClosed) emit(GroupJoinCodeLoading());

    try {
      final code = await _firestoreService.getJoinCode(habitId);

      if (code == null) {
        if (!isClosed) emit(GroupJoinCodeFailure("Join code not found"));
      } else {
        if (!isClosed) emit(GroupJoinCodeLoaded(code));
      }
    } catch (e) {
      if (!isClosed) emit(GroupJoinCodeFailure(e.toString()));
    }
  }
}
