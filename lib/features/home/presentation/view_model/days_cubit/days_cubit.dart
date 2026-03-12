import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/data/models/day_model.dart';

part 'days_state.dart';

class DaysCubit extends Cubit<DaysState> {
  DaysCubit(this._firestoreService, this._habitId) : super(DaysInitial()) {
    addDays();
    log('days cubit created');
    getCheckin();
  }

  final FirestoreService _firestoreService;
  StreamSubscription? _daysSubscription;
  final User? _user = getIt.get<FirebaseAuthService>().getCurrentUser();
  final String _habitId;
  final _date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // add days

  Future<void> addDays() async {
    try {
      emit(DaysLoading());
      await _firestoreService.addCheckIn(
        habitId: _habitId,
        checkIn: CheckInModel(
          userId: _user!.uid,
          date: DateTime.now().toIso8601String(),
          status: CheckInStatus.success,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      emit(DaysFailure(errMessage: e.toString()));
      log(e.toString());
    }
  }

  // listen to days

  void listenToDays() {
    emit(DaysLoading());

    _daysSubscription?.cancel();

    _daysSubscription = _firestoreService
        .getAllDaysStream(_habitId)
        .listen(
          (days) {
            emit(DaysLoaded(days: days));
          },
          onError: (error) {
            emit(DaysFailure(errMessage: error.toString()));
          },
        );
  }

  // update checkin status

  void updateCheckInStatus(String userId, CheckInStatus checkInStatus) async {
    emit(DaysCheckinUpdateLoading());

    try {
      _firestoreService.updateCheckInStatus(
        habitId: _habitId,
        date: _date,
        userId: userId,
        status: checkInStatus,
      );
      listenToDays();
      // emit(DaysCheckinUpdateSuccess());
    } catch (e) {
      log(e.toString());
      emit(DaysCheckinUpdateFailure(errMessage: e.toString()));
    }
  }

  // update chickin message

  void updateCheckInMessage(String userId, String message) async {
    emit(DaysCheckinUpdateLoading());

    try {
      _firestoreService.updateCheckInMessage(
        habitId: _habitId,
        date: _date,
        userId: userId,
        message: message,
      );
      emit(DaysCheckinUpdateSuccess());
    } catch (e) {
      log(e.toString());
      emit(DaysCheckinUpdateFailure(errMessage: e.toString()));
    }
  }

  Future<List<CheckInModel>> getCheckin() async {
    List<CheckInModel> data = [];

    try {
      data.addAll(
        await _firestoreService.getTodayCheckIns(
          habitId: _habitId,
          date: _date,
        ),
      );
    } catch (e) {
      log(e.toString());
    }
    return data;
  }

  // get checkin status

  // get checkin message

  @override
  Future<void> close() {
    _daysSubscription?.cancel();
    log('days cubit closed');
    return super.close();
  }
}
