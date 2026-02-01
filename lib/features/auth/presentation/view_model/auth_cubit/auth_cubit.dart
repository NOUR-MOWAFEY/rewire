import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._firebaseService) : super(AuthInitial());
  final FirebaseService _firebaseService;

  void login(String email, String password) async {
    try {
      emit(AuthLoading());
      await _firebaseService.signIn(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(errMessage: e.toString()));
    }
  }

  void register(String email, String password) async {
    try {
      emit(AuthLoading());
      await _firebaseService.signUp(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(errMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    await _firebaseService.signOut();
  }
}
