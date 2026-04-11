import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/view_model/invitations_cubit/invitations_cubit.dart';
import 'package:rewire/features/home/presentation/views/invitations_view/widgets/invitation_item.dart';

class InvitationsViewBody extends StatelessWidget {
  const InvitationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          const Text('Group Invitations', style: AppStyles.textStyle28),
          const SizedBox(height: 24),

          Expanded(
            child: BlocBuilder<InvitationsCubit, InvitationsState>(
              builder: (context, state) {
                if (state is InvitationsSuccess) {
                  if (state.invitations.isEmpty) {
                    return const Center(
                      child: Text(
                        'No pending invitations',
                        style: TextStyle(color: Colors.white60),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.invitations.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InvitationItem(invitation: state.invitations[index]),
                          index == state.invitations.length - 1
                              ? const SizedBox(height: 90)
                              : const SizedBox(height: 0),
                        ],
                      );
                    },
                  );
                } else if (state is InvitationsFailure) {
                  return Center(
                    child: Text(
                      state.errMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const CustomLoading();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
