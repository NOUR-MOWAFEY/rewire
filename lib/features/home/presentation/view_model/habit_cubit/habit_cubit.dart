import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/features/home/data/models/habit_model.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit(this._firestoreService, this.user) : super(HabitInitial()) {
    listenToHabits(user!.uid);
  }

  final FirestoreService _firestoreService;
  final User? user;
  StreamSubscription? _subscription;

  // listen to habits
  void listenToHabits(String userId) {
    _subscription = _firestoreService
        .listenToHabits(userId)
        .listen((habits) => emit(HabitSucess(habits: habits)));
  }

  // get all habits
  // Future<void> getHabits() async {
  //   try {
  //     emit(HabitLoading());
  //     var habits = await _firestoreService.getUserHabits(user!.uid);
  //     emit(HabitSucess(habits: habits));
  //   } catch (e) {
  //     emit(HabitFailure(errMessage: 'Failed to get habits, error:$e'));
  //   }
  // }

  // create habit
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
