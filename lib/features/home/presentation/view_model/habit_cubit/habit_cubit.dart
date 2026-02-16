import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/shared_preferences_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

import '../../../../../core/services/firestore_service.dart';
import '../../../data/models/habit_model.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit(this._firestoreService, this.user) : super(HabitInitial()) {
    listenToHabits(user!.uid);
    isNewDay();
  }

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
      emit(HabitSuccess(habits: habits));
    });
  }

  // =====================
  // Create habits
  // =====================

  Future<void> createHabit(String title) async {
    try {
      emit(HabitLoading());
      HabitModel habitModel = HabitModel(
        title: title,
        createdBy: user!.uid,
        participants: [user!.uid],
        isActive: true,
      );
      await _firestoreService.createHabit(habitModel);
      emit(HabitCreated());
    } catch (e) {
      emit(HabitFailure(errMessage: 'Error to create habit, error: $e'));
      log(e.toString());
    }
  }

  //  Checkin methods

  Future<void> createChceckIn() async {
    await _firestoreService.addCheckIn(
      habitId: '26IFJDndba5yYr8IcMyA',
      checkIn: CheckInModel(
        userId: user!.uid,
        date: DateTime.now().toIso8601String(),
        status: CheckInStatus.success,
        createdAt: DateTime.now(),
      ),
    );
  }

  // get user data
  Future<UserModel?>? getUserData() async {
    var data = await _firestoreService.getUser(user!.uid);
    return data;
  }


  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
