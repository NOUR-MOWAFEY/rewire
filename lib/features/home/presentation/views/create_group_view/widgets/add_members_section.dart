import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/add_members_field.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/members_list_view.dart';

class AddMembersSection extends StatelessWidget {
  const AddMembersSection({super.key, required this.memberEmailController});
  final TextEditingController memberEmailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
         AddMembersField(memberEmailController: memberEmailController,),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Text(
            'Added Members (10)',
            style: AppStyles.textStyle18.copyWith(fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.48,
          child: const MembersListView(),
        ),
      ],
    );
  }
}
