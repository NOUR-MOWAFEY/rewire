part of 'join_group_cubit.dart';

abstract class JoinGroupState {}

class JoinGroupInitial extends JoinGroupState {}

class JoinGroupLoading extends JoinGroupState {}


class JoinGroupJoined extends JoinGroupState {}


class JoinCodeLoaded extends JoinGroupState {
  final String joinCode;
  JoinCodeLoaded({required this.joinCode});
}

class JoinGroupFailure extends JoinGroupState {
  final String errMessage;
  JoinGroupFailure({required this.errMessage});
}