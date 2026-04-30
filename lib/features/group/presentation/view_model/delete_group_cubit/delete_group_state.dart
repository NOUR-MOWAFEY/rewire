part of 'delete_group_cubit.dart';

@immutable
sealed class DeleteGroupState {}

final class DeleteGroupInitial extends DeleteGroupState {}

final class DeleteGroupLoading extends DeleteGroupState {}

final class DeleteGroupSuccess extends DeleteGroupState {}

final class DeleteGroupFailure extends DeleteGroupState {
  final String errMessage;

  DeleteGroupFailure({required this.errMessage});
}
