import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/data/models/day_model.dart';

part 'days_state.dart';

class DaysCubit extends Cubit<DaysState> {
  DaysCubit(this._firestoreService, {required this.habitId})
    : super(DaysInitial()) {
    addDays();
    log('days cubit created');
  }

  final FirestoreService _firestoreService;
  StreamSubscription? _daysSubscription;
  final User? _user = getIt.get<FirebaseAuthService>().getCurrentUser();
  final String habitId;

  // add days

  Future<void> addDays() async {
    try {
      emit(DaysLoading());
      await _firestoreService.addCheckIn(
        habitId: habitId,
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
        .getAllDaysStream(habitId)
        .listen(
          (days) {
            emit(DaysLoaded(days: days));
          },
          onError: (error) {
            emit(DaysFailure(errMessage: error.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    _daysSubscription?.cancel();
    log('days cubit closed');
    return super.close();
  }
}
