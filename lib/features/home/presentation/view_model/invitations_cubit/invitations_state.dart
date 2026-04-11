part of 'invitations_cubit.dart';

@immutable
abstract class InvitationsState {}

class InvitationsInitial extends InvitationsState {}

class InvitationsLoading extends InvitationsState {}

class InvitationsSuccess extends InvitationsState {
  final List<InvitationModel> invitations;
  final String? loadingId;
  final bool isDeclining;

  InvitationsSuccess({
    required this.invitations,
    this.loadingId,
    this.isDeclining = false,
  });
}

class InvitationsFailure extends InvitationsState {
  final String errMessage;

  InvitationsFailure({required this.errMessage});
}
