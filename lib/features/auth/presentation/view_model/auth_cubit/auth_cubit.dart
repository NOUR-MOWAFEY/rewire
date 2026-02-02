import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/firebase_auth_error_handler.dart';

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
      await _firebaseService.signIn(email.trim(), password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(errMessage: FirebaseAuthErrorHandler.message(e)));
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(errMessage: 'Somthing went wrong, try again'));
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      emit(AuthLoading());
      var userCredential = await _firebaseService.signUp(
        email.trim(),
        password,
      );
      await _firestoreService.createUser(
        email.trim(),
        name.trim(),
        userCredential.user!.uid,
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(errMessage: FirebaseAuthErrorHandler.message(e)));
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(errMessage: 'Somthing went wrong, try again'));
    }
  }

  Future<void> logout() async {
    await _firebaseService.signOut();
  }
}
