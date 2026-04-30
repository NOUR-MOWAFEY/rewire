import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import 'add_members_field.dart';
import 'invited_group_members_list_view.dart';

class AddMembersSection extends StatelessWidget {
  const AddMembersSection({super.key});

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

        const AddMembersField(),

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
