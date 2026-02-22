import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/firestore_service.dart';

part 'join_group_state.dart';

class JoinGroupCubit extends Cubit<JoinGroupState> {
  final FirestoreService firestoreService;
  final FirebaseAuthService authService;

  JoinGroupCubit(this.firestoreService, this.authService)
    : super(JoinGroupInitial());

  Future<void> join({
    required String joinCode,
    required String password,
  }) async {
    emit(JoinGroupLoading());

    try {
      final userId = authService.getCurrentUser()!.uid;

      await firestoreService.joinGroup(
        joinCode: joinCode,
        password: password,
        userId: userId,
      );

      emit(JoinGroupSuccess());
    } catch (e) {
      emit(JoinGroupFailure(errMessage: e.toString()));
    }
  }
}
