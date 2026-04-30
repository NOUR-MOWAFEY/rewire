import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import '../../../../data/models/checkin_model.dart';
import '../../../view_model/days_cubit/days_cubit.dart';

class PopupMenuCheckInIcons extends StatelessWidget {
  const PopupMenuCheckInIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),

      child: const Row(
        mainAxisAlignment: .center,
        children: [
          PopupMenuCheckInIconbutton(icon: FontAwesomeIcons.circleCheck),
          SizedBox(width: 6),
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
    return Expanded(
      child: CustomButton(
        onPressed: () {
          final userId = context.read<AuthCubit>().getUser()!.uid;
          final daysCubit = context.read<DaysCubit>();

          switch (icon) {
            case FontAwesomeIcons.circleCheck:
              daysCubit.updateCheckInStatus(userId, CheckInStatus.success);
              context.pop();
              break;

            case FontAwesomeIcons.circleXmark:
              daysCubit.updateCheckInStatus(userId, CheckInStatus.fail);
              context.pop();
              break;
            default:
          }
        },
        child: Icon(icon, size: 30, color: AppColors.white),
      ),
    );
  }
}
