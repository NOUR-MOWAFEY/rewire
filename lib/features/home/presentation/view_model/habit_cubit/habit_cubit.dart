import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/shared_preferences_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

import '../../../../../core/services/firestore_service.dart';
import '../../../data/models/group_model.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit(this._firestoreService, this.user) : super(HabitInitial()) {
    log('Habit Cubit Created');
    listenToHabits(user!.uid);
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
  // Listen to habits
  // =====================

  void listenToHabits(String userId) async {
    await getUserData()?.then((value) => userModel = value);
    _subscription = _firestoreService.listenToHabits(userId).listen((habits) {
      if (!isClosed) emit(HabitSuccess(groups: habits));
    });
  }

  // =====================
  // Create habits
  // =====================

  Future<void> createHabit(String title, String password) async {
    try {
      isLoading = true;
      emit(HabitLoading());
      GroupModel habitModel = GroupModel(
        id: '',
        joinCode: await _firestoreService.generateUniqueJoinCode(),
        passwordHash: password,
        title: title,
        createdBy: user!.uid,
        participants: [user!.uid],
        isActive: true,
      );
      await _firestoreService.createHabit(habitModel);
      if (!isClosed) emit(HabitCreated());
    } catch (e) {
      isLoading = false;
      if (!isClosed) emit(HabitFailure(errMessage: e.toString()));
      log(e.toString());
    }
  }

  // get user data
  Future<UserModel?>? getUserData() async {
    var data = await _firestoreService.getUser(user!.uid);
    return data;
  }

  @override
  Future<void> close() {
    log('Habit Cubit Closed');
    _subscription?.cancel();
    return super.close();
  }
}
