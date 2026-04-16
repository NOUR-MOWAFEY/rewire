import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_circular_loading.dart';
import 'package:rewire/features/home/presentation/view_model/invitations_cubit/invitations_cubit.dart';
import 'package:rewire/features/home/presentation/views/invitations_view/widgets/invitation_view_header.dart';
import 'package:rewire/features/home/presentation/views/invitations_view/widgets/invitations_error_body.dart';
import 'package:rewire/features/home/presentation/views/invitations_view/widgets/invitations_list.dart';
import 'package:rewire/features/home/presentation/views/invitations_view/widgets/invitations_list_empty.dart';

class InvitationsViewBody extends StatelessWidget {
  const InvitationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: BlocBuilder<InvitationsCubit, InvitationsState>(
        builder: (context, state) {
          if (state is InvitationsSuccess) {
            if (state.invitations.isEmpty) {
              // if list is empty
              return const InvitationsListEmpty();
            }

            // invitations list
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: InvitationsViewHeader()),
                InvitationsList(invitations: state.invitations),
              ],
            );
          } else if (state is InvitationsFailure) {
            // error body
            return InvitationsErrorBody(errMessage: state.errMessage);
          } else {
            // loading body
            return ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                const Center(child: CustomCircularLoading()),
              ],
            );
          }
        },
      ),
    );
  }
}
