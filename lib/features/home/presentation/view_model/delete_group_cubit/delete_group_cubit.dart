import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';

part 'delete_group_state.dart';

class DeleteGroupCubit extends Cubit<DeleteGroupState> {
  DeleteGroupCubit(this._firestoreService) : super(DeleteGroupInitial());
  final FirestoreService _firestoreService;

  // =====================
  // Delete Group
  // =====================

  Future<void> deleteGroup(String habitId) async {
    emit(DeleteGroupLoading());

    try {
      await _firestoreService
          .deleteGroup(habitId)
          .timeout(
            Duration(seconds: 10),
            onTimeout: () => throw 'Bad internet connection',
          );
      emit(DeleteGroupSuccess());
    } catch (e) {
      log(e.toString());
      emit(DeleteGroupFailure(errMessage: e.toString()));
    }
  }
}
