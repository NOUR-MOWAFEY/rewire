import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/firestore_service.dart';

part 'join_group_state.dart';

class JoinGroupCubit extends Cubit<JoinGroupState> {
  final FirestoreService _firestoreService;
  final FirebaseAuthService _authService;

  JoinGroupCubit(this._firestoreService, this._authService)
    : super(JoinGroupInitial());

  Future<void> join({
    required String joinCode,
    required String password,
  }) async {
    emit(JoinGroupLoading());

    try {
      final userId = _authService.getCurrentUser()!.uid;

      await _firestoreService.joinGroup(
        joinCode: joinCode,
        password: password,
        userId: userId,
      );

      emit(JoinGroupJoined());
    } catch (e) {
      emit(JoinGroupFailure(errMessage: e.toString()));
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
