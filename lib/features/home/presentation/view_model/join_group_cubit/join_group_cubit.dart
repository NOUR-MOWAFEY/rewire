import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/firestore_service.dart';

part 'join_group_state.dart';

class JoinGroupCubit extends Cubit<JoinGroupState> {
  final FirestoreService _firestoreService;
  final FirebaseAuthService _authService;

  JoinGroupCubit(this._firestoreService, this._authService)
    : super(JoinGroupInitial());

  Future<void> joinGroup({
    required String joinCode,
    required String password,
  }) async {
    emit(JoinGroupLoading());

    try {
      final userId = _authService.getCurrentUser()!.uid;

      await _firestoreService.joinGroup(
        joinCode: joinCode.trim().toUpperCase(),
        password: password,
        userId: userId,
      );

      emit(JoinGroupJoined());
    } catch (e) {
      log(e.toString());
      emit(JoinGroupFailure(errMessage: e.toString()));
    }
  }

  Future<void> joinGroupViaId({required String groupId}) async {
    emit(JoinGroupLoading());

    try {
      final userId = _authService.getCurrentUser()!.uid;

      await _firestoreService.joinGroupViaId(groupId: groupId, userId: userId);

      emit(JoinGroupJoined());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(JoinGroupRequestFailed(e.toString()));

      await Future.delayed(Duration(seconds: 3));

      if (!isClosed) emit(JoinGroupInitial());
    }
  }

  Future<void> getJoinCode(String habitId) async {
    emit(JoinGroupLoading());

    try {
      final code = await _firestoreService.getJoinCode(habitId);

      if (code == null) {
        emit(JoinGroupFailure(errMessage: "Join code not found"));
      } else {
        emit(JoinCodeLoaded(joinCode: code));
      }
    } catch (e) {
      emit(JoinGroupFailure(errMessage: e.toString()));
    }
  }
}
