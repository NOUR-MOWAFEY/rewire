part of 'invitations_cubit.dart';

@immutable
abstract class InvitationsState {}

class InvitationsInitial extends InvitationsState {}

class InvitationsLoading extends InvitationsState {}

class InvitationsSuccess extends InvitationsState {
  final List<InvitationModel> invitations;

  InvitationsSuccess({required this.invitations});
}

class InvitationsFailure extends InvitationsState {
  final String errMessage;

  InvitationsFailure({required this.errMessage});
}
