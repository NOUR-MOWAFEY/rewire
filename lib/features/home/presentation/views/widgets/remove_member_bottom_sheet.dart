import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

class RemoveMemberBottomSheet extends StatelessWidget {
  const RemoveMemberBottomSheet({
    super.key,
    required this.member,
    required this.groupId,
  });

  final UserModel member;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Avatar + name
          CircleAvatar(
            // backgroundImage: NetworkImage(member.),
            radius: 30,
          ),
          const SizedBox(height: 12),
          Text(
            member.name,
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(
            'Are you sure you want to remove this member?',
            textAlign: TextAlign.center,
            style: AppStyles.textStyle14.copyWith(color: Colors.grey.shade400),
          ),

          const SizedBox(height: 24),

          // Buttons
          Row(
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
                  builder: (context, state) {
                    if (state is MembersLoading) {
                      return CustomButton(
                        color: Colors.grey,
                        height: 45,
                        child: const CustomLoading(size: 20),
                      );
                    }
                    return CustomButton(
                      onPressed: () async {
                        await context
                            .read<MembersCubit>()
                            .removeMemberFromGroup(groupId, member);

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
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
