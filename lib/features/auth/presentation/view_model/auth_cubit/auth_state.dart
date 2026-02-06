part of 'auth_cubit.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final User? user;

  const AuthAuthenticated({required this.user});
}

final class AuthUnAuthenticated extends AuthState {}

final class AuthFailure extends AuthState {
  final String? errMessage;

  const AuthFailure({required this.errMessage});
}
