part of 'group_cubit.dart';

@immutable
sealed class GroupState {
  const GroupState();
}

final class GroupInitial extends GroupState {}

final class GroupSuccess extends GroupState {
  final List<GroupModel>? groups;

  const GroupSuccess({this.groups});
}

final class GroupFailure extends GroupState {
  final String errMessage;

  const GroupFailure({required this.errMessage});
}

final class GroupLoading extends GroupState {}

// Update States

final class GroupUpdateSuccess extends GroupState {}

final class GroupUpdateLoading extends GroupState {}

final class GroupUpdateFailure extends GroupState {
  final String errMessage;

  const GroupUpdateFailure({required this.errMessage});
}
