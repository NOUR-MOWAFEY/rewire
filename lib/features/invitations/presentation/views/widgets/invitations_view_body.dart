import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/invitations_cubit/invitations_cubit.dart';
import 'invitation_view_header.dart';
import 'invitations_error_body.dart';
import 'invitations_list.dart';
import 'invitations_list_empty.dart';

class InvitationsViewBody extends StatelessWidget {
  const InvitationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: BlocBuilder<InvitationsCubit, InvitationsState>(
        builder: (context, state) {
          if (state is InvitationsFailure) {
            // error body
            return InvitationsErrorBody(errMessage: state.errMessage);
          }

          if (state is InvitationsSuccess && state.invitations.isEmpty) {
            // if list is empty
            return const InvitationsListEmpty();

            // invitations list
          }

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: InvitationsViewHeader()),
              InvitationsList(
                invitations: state is InvitationsSuccess
                    ? state.invitations
                    : null,
                isLoading: state is InvitationsLoading,
              ),
            ],
          );
        },
      ),
    );
  }
}
