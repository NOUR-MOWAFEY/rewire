import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_circular_loading.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

class RemoveBottomSheetButtons extends StatelessWidget {
  const RemoveBottomSheetButtons({
    super.key,
    required this.groupId,
    required this.member,
  });

  final String groupId;
  final UserModel member;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: () => context.pop(),
            title: 'Cancel',
            height: 45,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: BlocBuilder<MembersCubit, MembersState>(
            buildWhen: (previous, current) =>
                current is MembersRemoved ||
                current is MembersLoading ||
                current is MembersError,

            builder: (context, state) {
              if (state is MembersLoading) {
                return CustomButton(
                  color: Colors.grey,
                  height: 45,
                  child: const CustomCircularLoading(size: 20),
                );
              }
              return CustomButton(
                onPressed: () async {
                  await context.read<MembersCubit>().removeMemberFromGroup(
                    groupId,
                    member,
                  );

                  if (!context.mounted) return;

                  context.pop();
                },
                height: 45,
                title: 'Remove',
                color: AppColors.red,
              );
            },
          ),
        ),
      ],
    );
  }
}
