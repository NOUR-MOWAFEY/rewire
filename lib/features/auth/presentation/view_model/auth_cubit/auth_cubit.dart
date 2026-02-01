import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/firebase_service.dart';
import '../../../../../core/services/firestore_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._firebaseService, this._firestoreService)
    : super(AuthInitial());
  final FirebaseService _firebaseService;
  final FirestoreService _firestoreService;

  void login(String email, String password) async {
    try {
      emit(AuthLoading());
      await _firebaseService.signIn(email, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(errMessage: e.toString()));
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      emit(AuthLoading());
      var userCredential = await _firebaseService.signUp(email, password);
      await _firestoreService.createUser(email, name, userCredential.user!.uid);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(errMessage: e.toString()));
      log(e.toString());
    }
  }

  Future<void> logout() async {
    await _firebaseService.signOut();
  }
}
