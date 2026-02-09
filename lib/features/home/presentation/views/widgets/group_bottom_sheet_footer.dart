import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/presentation/view_model/habit_cubit/habit_cubit.dart';

class GroupBottomSheetFooter extends StatelessWidget {
  const GroupBottomSheetFooter({
    super.key,
    required this.groupNameKey,
    required this.groupNameController,
  });

  final GlobalKey<FormState> groupNameKey;
  final TextEditingController groupNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            title: 'Create Group',
            onPressed: () async {
              if (!groupNameKey.currentState!.validate()) return;
              await BlocProvider.of<HabitCubit>(
                context,
              ).createHabit(groupNameController.text.trim());
            },
          ),
        ),
        const SizedBox(width: 8),
        CustomButton(
          onPressed: () {},
          width: 50,
          child: const Icon(FontAwesomeIcons.plus, color: AppColors.white),
        ),
      ],
    );
  }
}
