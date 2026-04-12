import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/add_members_field.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/invited_group_members_list_view.dart';

class AddMembersSection extends StatelessWidget {
  const AddMembersSection({super.key, required this.memberEmailController});
  final TextEditingController memberEmailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            'Invite Members',
            style: AppStyles.textStyle14.copyWith(
              color: AppColors.secondary2,
              letterSpacing: 0.5,
            ),
          ),
        ),

        const SizedBox(height: 8),

        AddMembersField(memberEmailController: memberEmailController),

        const SizedBox(height: 10),

        //  divider before the list
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.primary.withValues(alpha: 0.2),
        ),

        const SizedBox(height: 4),

        const InvitedGroupMembersListView(),
      ],
    );
  }
}
