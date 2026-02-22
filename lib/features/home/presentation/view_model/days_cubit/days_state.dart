part of 'days_cubit.dart';

@immutable
sealed class DaysState {}

final class DaysInitial extends DaysState {}

final class DaysLoading extends DaysState {}

final class DaysLoaded extends DaysState {
  final List<DayModel> days;

  DaysLoaded({required this.days});
}

final class DaysFailure extends DaysState {
  final String errMessage;

  DaysFailure({required this.errMessage});
}
