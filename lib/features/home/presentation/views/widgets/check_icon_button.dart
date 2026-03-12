import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popover/popover.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/presentation/view_model/days_cubit/days_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../group_details_view/widgets/popup_menu.dart';

class CheckIconButton extends StatelessWidget {
  const CheckIconButton({
    super.key,
    this.color = AppColors.white,
    this.icon = FontAwesomeIcons.circleDot,
    required this.index,
    required this.checkInStatus,
  });
  final Color? color;
  final IconData? icon;
  final int index;
  final CheckInStatus checkInStatus;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final daysCubit = context.read<DaysCubit>();

        showPopover(
          context: context,
          bodyBuilder: (_) => BlocProvider.value(
            value: daysCubit,
            child: PopUpMenu(isFirstOne: index == 0),
          ),
          direction: PopoverDirection.bottom,
          height: index == 0 ? 210 : 160,
          width: 280,
          radius: 28,
          arrowDyOffset: -4,
          backgroundColor: AppColors.alertDialogColor,
        );
      },
      icon: Icon(
        switch (checkInStatus) {
          CheckInStatus.success => FontAwesomeIcons.circleCheck,

          CheckInStatus.fail => FontAwesomeIcons.circleXmark,

          CheckInStatus.pending => FontAwesomeIcons.circleDot,
        },
        size: 38,
        color: index == 0 ? const Color.fromARGB(255, 128, 227, 209) : color,
      ),
    );
  }
}
