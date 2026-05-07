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
          PopupMenuCheckInIconbutton(icon: FontAwesomeIcons.check),
          SizedBox(width: 8),
          PopupMenuCheckInIconbutton(icon: FontAwesomeIcons.xmark),
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
            case FontAwesomeIcons.check:
              daysCubit.updateCheckInStatus(userId, CheckInStatus.success);
              context.pop();
              break;

            case FontAwesomeIcons.xmark:
              daysCubit.updateCheckInStatus(userId, CheckInStatus.fail);
              context.pop();
              break;
            default:
          }
        },
        child: Icon(icon, size: 21, color: AppColors.white),
      ),
    );
  }
}
