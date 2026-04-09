import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/view_model/join_group_cubit/join_group_cubit.dart';

class JoinGroupFormButtons extends StatelessWidget {
  const JoinGroupFormButtons({
    super.key,
    required this.groupId,
    required this.groupPassword,
  });

  final TextEditingController groupId;
  final TextEditingController groupPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(title: 'Cancel', onPressed: () => context.pop()),

        const SizedBox(height: 8),

        BlocConsumer<JoinGroupCubit, JoinGroupState>(
          listener: (context, state) {
            if (state is JoinGroupFailure) {
              ShowToastification.failure(context, state.errMessage);
            }

            if (state is JoinGroupJoined) {
              ShowToastification.success(
                context,
                'You\'ve successfully joined the group.',
              );
              context.pop();
            }
          },

          builder: (context, state) {
            if (state is JoinGroupLoading || state is JoinGroupJoined) {
              return const CustomButton(
                color: Colors.grey,
                child: CustomLoading(size: 20),
              );
            }

            return CustomButton(
              title: 'Join',
              onPressed: () {
                if (groupId.text.trim().isEmpty || groupPassword.text.isEmpty) {
                  ShowToastification.failure(context, 'All fields requied');
                  return;
                }

                context.read<JoinGroupCubit>().joinGroup(
                  joinCode: groupId.text,
                  password: groupPassword.text,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
