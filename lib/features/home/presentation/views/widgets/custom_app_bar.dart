import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/features/home/presentation/view_model/habit_cubit/habit_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import 'user_main_info.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 4),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const UserMainInfo(),
            const Spacer(),
            IconButton(
              onPressed: () async {
                // await context.read<AuthCubit>().logout();
                // if (context.mounted) {
                //   context.go(AppRouter.loginView);
                // }
                await BlocProvider.of<HabitCubit>(context).isNewDay();
              },
              icon: const Icon(FontAwesomeIcons.gear, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
