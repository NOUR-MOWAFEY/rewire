import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore/firestore_service.dart';

import '../../../../../core/services/firebase_auth_service.dart';

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
    if (!isClosed) emit(JoinGroupLoading());

    try {
      final userId = _authService.getCurrentUser()!.uid;

      await _firestoreService.joinGroup(
        joinCode: joinCode.trim().toUpperCase(),
        password: password,
        userId: userId,
      );

      if (!isClosed) emit(JoinGroupJoined());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(JoinGroupFailure(errMessage: e.toString()));
    }
  }

  Future<void> joinGroupViaId({required String groupId}) async {
    if (!isClosed) emit(JoinGroupLoading());

    try {
      final userId = _authService.getCurrentUser()!.uid;

      await _firestoreService.joinGroupViaId(groupId: groupId, userId: userId);

      if (!isClosed) emit(JoinGroupJoined());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(JoinGroupRequestFailed(e.toString()));

      await Future.delayed(Duration(seconds: 3));

      if (!isClosed) emit(JoinGroupInitial());
    }
  }
}
