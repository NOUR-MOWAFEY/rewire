import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_circular_loading.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/members_list_view.dart';
import 'package:rewire/features/home/presentation/views/widgets/pending_member_item.dart';

class CustomAccordionBody extends StatelessWidget {
  const CustomAccordionBody({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,

      child: BlocBuilder<MembersCubit, MembersState>(
        builder: (context, state) {
          if (state is MembersError) {
            log(state.errMassage);

            return const Center(
              child: Text(
                'Failed to load members',
                style: AppStyles.textStyle18,
              ),
            );
          }

          if (state is MembersLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Current Members'),
                  MembersListView(
                    users: state.members,
                    groupModel: groupModel,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),

                  if (state.pendingInvitations.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _buildSectionTitle('Pending Invitations'),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.pendingInvitations.length,

                      itemBuilder: (context, index) {
                        return PendingMemberItem(
                          invitation: state.pendingInvitations[index],
                        );
                      },
                    ),
                  ],
                ],
              ),
            );
          }
          return const CustomCircularLoading(size: 28);
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: AppStyles.textStyle14.copyWith(
          color: Colors.white60,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
