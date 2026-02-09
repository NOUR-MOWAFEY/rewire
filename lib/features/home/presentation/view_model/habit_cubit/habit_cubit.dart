import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/shared_preferences_service.dart';
import 'package:rewire/core/utils/service_locator.dart';

import '../../../../../core/services/firestore_service.dart';
import '../../../data/models/habit_model.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit(this._firestoreService, this.user) : super(HabitInitial()) {
    listenToHabits(user!.uid);
  }

  final FirestoreService _firestoreService;
  final User? user;
  StreamSubscription? _subscription;

  // =====================
  // Date Check
  // =====================

  Future<bool> isNewDay() async {
    final storage = getIt.get<SharedPreferencesService>();

    final today = DateTime.now();
    final normalizedToday = DateTime(today.day, today.month, today.year);

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

  void listenToHabits(String userId) {
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

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
