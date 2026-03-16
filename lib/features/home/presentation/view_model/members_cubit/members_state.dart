part of 'members_cubit.dart';

@immutable
sealed class MembersState {}

final class MembersInitial extends MembersState {}

final class MembersAdded extends MembersState {}

final class MembersRemoved extends MembersState {}

final class MembersLoading extends MembersState {}

final class MembersLoaded extends MembersState {
  final List<UserModel> members;

  MembersLoaded({required this.members});
}

final class MembersFound extends MembersState {
  final UserModel user;

  MembersFound({required this.user});
}

final class MembersNotFound extends MembersState {
  final String errMessage;

  MembersNotFound({required this.errMessage});
}

final class MembersError extends MembersState {
  final String errMassage;

  MembersError({required this.errMassage});
}
