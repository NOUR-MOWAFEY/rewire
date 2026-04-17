import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/features/home/data/models/invitation_model.dart';

part 'invitations_state.dart';

class InvitationsCubit extends Cubit<InvitationsState> {
  final FirestoreService _firestoreService;
  final String _userId;

  InvitationsCubit(this._firestoreService, this._userId)
    : super(InvitationsInitial()) {
    listenToInvitations();
  }

  StreamSubscription? _invitationsSubscription;

  void listenToInvitations() {
    if (!isClosed) emit(InvitationsLoading());
    _invitationsSubscription?.cancel();
    _invitationsSubscription = _firestoreService
        .listenToInvitations(_userId)
        .listen(
          (invitations) {
            if (!isClosed) emit(InvitationsSuccess(invitations: invitations));
          },
          onError: (e) {
            if (!isClosed) emit(InvitationsFailure(errMessage: e.toString()));
          },
        );
  }

  Future<void> acceptInvitation(InvitationModel invitation) async {
    if (state is InvitationsSuccess) {
      final currentInvitations = (state as InvitationsSuccess).invitations;

      if (isClosed) return;

      emit(
        InvitationsSuccess(
          invitations: currentInvitations,
          loadingId: invitation.id,
          isDeclining: false,
        ),
      );

      try {
        await _firestoreService.respondToInvitation(
          invitation: invitation,
          accept: true,
        );
      } catch (e) {
        if (!isClosed) emit(InvitationsFailure(errMessage: e.toString()));
      }
    }
  }

  Future<void> declineInvitation(InvitationModel invitation) async {
    if (state is InvitationsSuccess) {
      final currentInvitations = (state as InvitationsSuccess).invitations;

      if (isClosed) return;

      emit(
        InvitationsSuccess(
          invitations: currentInvitations,
          loadingId: invitation.id,
          isDeclining: true,
        ),
      );

      try {
        await _firestoreService.respondToInvitation(
          invitation: invitation,
          accept: false,
        );
      } catch (e) {
        if (!isClosed) emit(InvitationsFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    _invitationsSubscription?.cancel();
    return super.close();
  }
}
