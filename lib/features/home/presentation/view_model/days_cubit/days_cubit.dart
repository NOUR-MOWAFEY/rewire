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
    today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    log('days cubit created');
  }

  final FirestoreService _firestoreService;
  StreamSubscription? _daysSubscription;
  final User? _user = getIt.get<FirebaseAuthService>().getCurrentUser();
  final String _habitId;
  late String today;

  final Map<String, List<CheckInModel>> daysCheckins = {};
  List<DayModel> daysList = [];

  // add days

  Future<void> addDays() async {
    await _firestoreService.addCheckIn(
      habitId: _habitId,
      checkIn: CheckInModel(
        userId: _user!.uid,
        date: DateTime.now().toIso8601String(),
        status: CheckInStatus.success,
        createdAt: DateTime.now(),
      ),
    );
  }

  // fetch days and checkins

  void listenToDays() async {
    if (!isClosed) emit(DaysLoading());

    _daysSubscription?.cancel();
    _checkinSub?.cancel();

    try {
      // 0. Ensure today's day & checkin exist before fetching
      await addDays();

      // 1. Fetch all days once
      daysList = await _firestoreService.getAllDaysFuture(_habitId);

      // 2. Fetch checkins for all days
      for (final day in daysList) {
        final checkins = await _firestoreService.getDayCheckInsFuture(
          habitId: _habitId,
          date: day.day,
        );
        daysCheckins[day.day] = checkins;
      }

      // 3. Emit loaded state with all fetched data
      if (!isClosed) emit(DaysLoaded(days: daysList));

      // 4. Start listening to today's checkins only
      listenToTodayCheckins();
    } catch (e) {
      log('Error fetching days and checkins: $e');

      if (!isClosed) emit(DaysFailure(errMessage: e.toString()));
    }
  }

  // update checkin status

  void updateCheckInStatus(String userId, CheckInStatus checkInStatus) async {
    try {
      _firestoreService.updateCheckInStatus(
        habitId: _habitId,
        date: today,
        userId: userId,
        status: checkInStatus,
      );
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(DaysCheckinUpdateFailure(errMessage: e.toString()));
    }
  }

  // update chickin message

  void updateCheckInMessage(String userId, String message) async {
    if (!isClosed) emit(DaysCheckinUpdateLoading());

    try {
      _firestoreService.updateCheckInMessage(
        habitId: _habitId,
        date: today,
        userId: userId,
        message: message,
      );
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(DaysCheckinUpdateFailure(errMessage: e.toString()));
    }
  }

  // listen to day checkins
  StreamSubscription? _checkinSub;

  void listenToTodayCheckins({String? date}) {
    _checkinSub?.cancel();

    final targetDate = date ?? today;

    _checkinSub = _firestoreService
        .getTodayCheckInsStream(habitId: _habitId, date: targetDate)
        .listen((checkins) {
          // Update the specific day's checkins in our map
          daysCheckins[targetDate] = checkins;

          // Emit loaded to rebuild UI with updated data from the stream
          if (!isClosed) emit(DaysLoaded(days: daysList));
        });
  }

  @override
  Future<void> close() {
    _checkinSub?.cancel();
    _daysSubscription?.cancel();
    log('days cubit closed');
    return super.close();
  }
}
