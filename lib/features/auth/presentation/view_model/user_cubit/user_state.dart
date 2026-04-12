part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;
  UserSuccess({required this.user});
}

class UserFailure extends UserState {
  final String errMessage;
  UserFailure({required this.errMessage});
}
