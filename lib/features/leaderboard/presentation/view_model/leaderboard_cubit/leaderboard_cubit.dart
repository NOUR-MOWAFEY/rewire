import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore/firestore_service.dart';

import '../../../../profile_view/data/models/user_model.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final FirestoreService _firestoreService;
  StreamSubscription<List<UserModel>>? _membersSubscription;

  LeaderboardCubit(this._firestoreService) : super(LeaderboardInitial());

  void getLeaderboard(String groupId) {
    if(!isClosed)   emit(LeaderboardLoading());

    _membersSubscription?.cancel();

    _membersSubscription = _firestoreService
        .listenToGroupMembers(groupId)
        .listen(
          (members) {
            if (!isClosed) {
              emit(LeaderboardSuccess(sortedMembers: members));
            }
          },
          onError: (error) {
            log(error.toString());
            if (!isClosed) {
              emit(LeaderboardFailure(errMessage: error.toString()));
            }
          },
        );
  }

  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    return super.close();
  }
}
