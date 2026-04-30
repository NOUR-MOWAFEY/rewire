part of 'group_cubit.dart';

@immutable
sealed class GroupState {}

final class GroupInitial extends GroupState {}

final class GroupSuccess extends GroupState {
  final List<GroupModel>? groups;

  GroupSuccess({this.groups});
}

final class GroupFailure extends GroupState {
  final String errMessage;

  GroupFailure({required this.errMessage});
}

final class GroupLoading extends GroupState {}

// Update States

final class GroupUpdateSuccess extends GroupState {}

final class GroupUpdateLoading extends GroupState {}

final class GroupUpdateFailure extends GroupState {
  final String errMessage;

  GroupUpdateFailure({required this.errMessage});
}

// Add Member States

final class GroupAddMemberSuccess extends GroupState {}

final class GroupAddMemberLoading extends GroupState {}

final class GroupAddMemberFailure extends GroupState {
  final String errMessage;

  GroupAddMemberFailure({required this.errMessage});
}

// Leave Group States

final class GroupLeaveSuccess extends GroupState {}

final class GroupLeaveLoading extends GroupState {}

final class GroupLeaveFailure extends GroupState {
  final String errMessage;

  GroupLeaveFailure({required this.errMessage});
}

// Join Code States

final class GroupJoinCodeLoaded extends GroupState {
  final String joinCode;

  GroupJoinCodeLoaded(this.joinCode);
}

final class GroupJoinCodeLoading extends GroupState {}

final class GroupJoinCodeFailure extends GroupState {
  final String errMessage;

  GroupJoinCodeFailure(this.errMessage);
}
