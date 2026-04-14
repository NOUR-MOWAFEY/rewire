part of 'leaderboard_cubit.dart';

@immutable
sealed class LeaderboardState {
  const LeaderboardState();
}

final class LeaderboardInitial extends LeaderboardState {}

final class LeaderboardLoading extends LeaderboardState {}

final class LeaderboardSuccess extends LeaderboardState {
  final List<UserModel> sortedMembers;

  const LeaderboardSuccess({required this.sortedMembers});
}

final class LeaderboardFailure extends LeaderboardState {
  final String errMessage;

  const LeaderboardFailure({required this.errMessage});
}
