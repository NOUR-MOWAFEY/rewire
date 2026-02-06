import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

import '../../../../../core/services/firebase_service.dart';
import '../../../../../core/services/firestore_service.dart';
import '../../../../../core/utils/firebase_auth_error_handler.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._firebaseAuthService, this._firestoreService)
    : super(AuthInitial());
  final FirebaseAuthService _firebaseAuthService;
  final FirestoreService _firestoreService;
  User? user;

  //get user
  User? getUser() {
    return _firebaseAuthService.getCurrentUser();
  }

  // login
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      var userCredential = await _firebaseAuthService.signIn(
        email.trim(),
        password,
      );
      emit(AuthAuthenticated(user: userCredential.user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(errMessage: FirebaseAuthErrorHandler.message(e)));
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(errMessage: 'Somthing went wrong, try again'));
    }
  }

  // register
  Future<void> register(String email, String password, String name) async {
    try {
      emit(AuthLoading());
      var userCredential = await _firebaseAuthService.signUp(
        email.trim(),
        password,
      );
      await _firestoreService.createUser(
        UserModel(
          uid: userCredential.user!.uid,
          name: name.trim(),
          email: email.trim(),
          joinedAt: DateTime.now(),
          overallScore: 0,
        ),
      );
      await logout();
      emit(AuthUnAuthenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(errMessage: FirebaseAuthErrorHandler.message(e)));
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(errMessage: 'Somthing went wrong, try again'));
    }
  }

  //  logout
  Future<void> logout() async {
    await _firebaseAuthService.signOut();
  }
}
