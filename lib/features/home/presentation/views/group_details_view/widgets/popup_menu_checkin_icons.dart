import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/presentation/view_model/days_cubit/days_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';

class PopupMenuCheckInIcons extends StatelessWidget {
  const PopupMenuCheckInIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),

      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          PopupMenuCheckInIconbutton(icon: FontAwesomeIcons.circleCheck),
          PopupMenuCheckInIconbutton(icon: FontAwesomeIcons.circleDot),
          PopupMenuCheckInIconbutton(icon: FontAwesomeIcons.circleXmark),
        ],
      ),
    );
  }
}

class PopupMenuCheckInIconbutton extends StatelessWidget {
  const PopupMenuCheckInIconbutton({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final userId = context.read<AuthCubit>().getUser()!.uid;
        final daysCubit = context.read<DaysCubit>();

        switch (icon) {
          case FontAwesomeIcons.circleCheck:
            daysCubit.updateCheckInStatus(userId, CheckInStatus.success);
            break;
          case FontAwesomeIcons.circleDot:
            daysCubit.updateCheckInStatus(userId, CheckInStatus.pending);
            break;
          case FontAwesomeIcons.circleXmark:
            daysCubit.updateCheckInStatus(userId, CheckInStatus.fail);
            break;
          default:
        }
      },
      icon: Icon(icon, size: 36, color: AppColors.white),
    );
  }
}
