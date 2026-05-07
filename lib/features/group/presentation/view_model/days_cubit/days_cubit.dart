import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/services/firestore/firestore_service.dart';

import '../../../../../core/services/firebase_auth_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/models/checkin_model.dart';
import '../../../data/models/day_model.dart';
import '../group_cubit/group_cubit.dart';

part 'days_state.dart';

class DaysCubit extends Cubit<DaysState> {
  DaysCubit(
    this._firestoreService,
    this._groupId, {
    required GroupCubit groupCubit,
  }) : _groupCubit = groupCubit,
       super(DaysInitial()) {
    today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    log('days cubit created');
  }

  final GroupCubit _groupCubit;

  final FirestoreService _firestoreService;
  StreamSubscription? _daysSubscription;
  final User? _user = getIt.get<FirebaseAuthService>().getCurrentUser();
  final String _groupId;
  late String today;

  final Map<String, List<CheckInModel>> daysCheckins = {};
  List<DayModel> daysList = [];

  // add days

  Future<void> addDays() async {
    if (!isClosed) emit(DaysLoading());

    await _firestoreService.fillMissingDays(groupId: _groupId);
    await _firestoreService.createDayIfNotExist(
      groupId: _groupId,
      userId: _user!.uid,
    );
  }

  // fetch days and checkins

  void listenToDays() async {
    if (!isClosed) emit(DaysLoading());
    // Check cache first
    final cachedDays = _groupCubit.daysCache[_groupId];
    if (cachedDays != null && cachedDays.isNotEmpty) {
      daysList = cachedDays;
      // Load checkins from cache too if they exist
      final cachedCheckins = _groupCubit.checkinsCache[_groupId];
      if (cachedCheckins != null) {
        daysCheckins.addAll(cachedCheckins);
      }
      if (!isClosed) emit(DaysLoaded(days: daysList));
      log('Loaded days from cache for group: $_groupId');
    } else {
      if (!isClosed) emit(DaysLoading());
    }

    _daysSubscription?.cancel();
    _checkinSub?.cancel();

    try {
      // 0. Ensure today's day & checkin exist before fetching (run in parallel)
      await Future.wait([
        _firestoreService.fillMissingDays(groupId: _groupId),
        _firestoreService.createDayIfNotExist(
          groupId: _groupId,
          userId: _user!.uid,
        ),
      ]);

      // 1. Fetch all days once
      daysList = await _firestoreService.getAllDaysFuture(_groupId);

      // 2. Fetch checkins for all days in parallel
      final checkinResults = await Future.wait(
        daysList.map(
          (day) => _firestoreService.getDayCheckInsFuture(
            groupId: _groupId,
            date: day.day,
          ),
        ),
      );
      for (int i = 0; i < daysList.length; i++) {
        daysCheckins[daysList[i].day] = checkinResults[i];
      }

      // 3. Emit loaded state with all fetched data
      if (!isClosed) emit(DaysLoaded(days: daysList));

      // 4. Update Cache
      _groupCubit.cacheDays(_groupId, daysList);
      for (var entry in daysCheckins.entries) {
        _groupCubit.cacheCheckins(_groupId, entry.key, entry.value);
      }

      // 5. Start listening to today's checkins only
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
        groupId: _groupId,
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
      await _firestoreService.updateCheckInMessage(
        groupId: _groupId,
        date: today,
        userId: userId,
        message: message,
      );
      if (!isClosed) emit(DaysCheckinUpdateLoaded());
      if (!isClosed) emit(DaysLoaded(days: daysList));
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
        .getTodayCheckInsStream(groupId: _groupId, date: targetDate)
        .listen((checkins) {
          // Update the specific day's checkins in our map
          daysCheckins[targetDate] = checkins;

          // Update Cache
          _groupCubit.cacheCheckins(_groupId, targetDate, checkins);

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
