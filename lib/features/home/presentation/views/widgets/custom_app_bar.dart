import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/presentation/view_model/habit_cubit/habit_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/profile_custom_text_field.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Hi, ${BlocProvider.of<HabitCubit>(context).userModel?.name.split(RegExp(r'\s+'))[0] ?? ''}',
          style: AppStyles.textStyle28,
        ),

        const Spacer(),

        CustomButton(
          width: 90,
          height: 40,
          title: 'Create',
          onPressed: () {
            context.push(AppRouter.createGroupView);
          },
        ),
        const SizedBox(width: 6),

        CustomButton(
          width: 65,
          height: 40,
          title: 'join',
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => const CustomAlertDialog(),
            );
          },
        ),
      ],
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: AppColors.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

      content: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
            colors: AppColors.gradientColors,
          ),
        ),
        height: 380,
        width: 350,
        child: Column(
          children: [
            const Text('Join Group', style: AppStyles.textStyle24),
            const SizedBox(height: 20),

            const ProfileCustomTextField(hintText: 'Group ID'),
            const SizedBox(height: 12),
            const ProfileCustomTextField(hintText: 'Password'),
            const SizedBox(height: 24),

            const Spacer(),

            CustomButton(title: 'Cancel', onPressed: () => context.pop()),
            const SizedBox(height: 8),
            CustomButton(title: 'Join', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
