import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';
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
        AddMembersField(memberEmailController: memberEmailController),

        const SizedBox(height: 16),

        BlocBuilder<MembersCubit, MembersState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 22,
                  ),
                  child: Text(
                    'Added Members (${context.read<MembersCubit>().members.length})',
                    style: AppStyles.textStyle18.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.48,
                  child: MembersListView(
                    users: context.read<MembersCubit>().members.toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
