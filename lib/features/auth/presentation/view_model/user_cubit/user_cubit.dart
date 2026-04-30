import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore/firestore_service.dart';

import '../../../../profile_view/data/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FirestoreService _firestoreService;
  StreamSubscription? _userSubscription;

  UserCubit(this._firestoreService) : super(UserInitial());

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void listenToUser(String userId) {
    emit(UserLoading());
    _userSubscription?.cancel();
    _userSubscription = _firestoreService.listenToUser(userId).listen(
      (user) {
        if (user != null) {
          _currentUser = user;
          emit(UserSuccess(user: user));
        } else {
          emit(UserFailure(errMessage: 'User not found'));
        }
      },
      onError: (e) {
        emit(UserFailure(errMessage: e.toString()));
      },
    );
  }

  Future<bool> updateName(String newName) async {
    if (_currentUser == null) return false;
    if (newName.trim() == _currentUser!.name || newName.trim().isEmpty) return false;

    try {
      final updatedUser = UserModel(
        uid: _currentUser!.uid,
        name: newName.trim(),
        email: _currentUser!.email,
        joinedAt: _currentUser!.joinedAt,
        overallScore: _currentUser!.overallScore,
        imageUpdatedAt: _currentUser!.imageUpdatedAt,
      );
      await _firestoreService.updateUser(updatedUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
