part of 'habit_cubit.dart';

@immutable
sealed class HabitState {
  const HabitState();
}

final class HabitInitial extends HabitState {}

final class HabitSucess extends HabitState {
  final List<HabitModel> habits;

  const HabitSucess({required this.habits});
}

final class HabitFailure extends HabitState {
  final String errMessage;

  const HabitFailure({required this.errMessage});
}

final class HabitLoading extends HabitState {}
