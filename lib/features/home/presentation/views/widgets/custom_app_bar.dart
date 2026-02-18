import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/presentation/view_model/habit_cubit/habit_cubit.dart';

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
        CustomButton(width: 65, height: 40, title: 'join', onPressed: () {}),
      ],
    );
  }
}
