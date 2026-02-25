part of 'habit_cubit.dart';

@immutable
sealed class HabitState {
  const HabitState();
}

final class HabitInitial extends HabitState {}

final class HabitSuccess extends HabitState {
  final List<GroupModel>? groups;

  const HabitSuccess({this.groups});
}

final class HabitFailure extends HabitState {
  final String errMessage;

  const HabitFailure({required this.errMessage});
}

final class HabitLoading extends HabitState {}

final class HabitCreated extends HabitState {}

final class HabitDeleteLoading extends HabitState {}

final class HabitDeleteSuccess extends HabitState {} 

final class HabitDeleteFailure extends HabitState {
  final String errMessage;

  const HabitDeleteFailure({required this.errMessage});
}
