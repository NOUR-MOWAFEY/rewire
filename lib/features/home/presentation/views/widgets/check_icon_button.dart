import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popover/popover.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/presentation/view_model/days_cubit/days_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../group_details_view/widgets/popup_menu.dart';

class CheckIconButton extends StatelessWidget {
  const CheckIconButton({
    super.key,
    this.color = AppColors.white,
    required this.checkIn,
    required this.isCurrentUser,
    required this.isTodayItem,
  });
  final Color? color;
  final CheckInModel checkIn;
  final bool isCurrentUser;
  final bool isTodayItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: IconButton(
        onPressed: () {
          final daysCubit = context.read<DaysCubit>();
          final membersCubit = context.read<MembersCubit>();

          showPopover(
            context: context,
            bodyBuilder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: daysCubit),
                BlocProvider.value(value: membersCubit),
              ],
              child: PopUpMenu(
                checkIn: checkIn,
                isCurrentUser: isCurrentUser,
                isTodayItem: isTodayItem,
              ),
            ),
            direction: PopoverDirection.bottom,
            height: isCurrentUser && isTodayItem ? 200 : 160,
            width: 250,
            radius: 28,
            arrowDyOffset: -10,
            backgroundColor: AppColors.alertDialogColor,
          );
        },
        icon: Icon(
          switch (checkIn.status) {
            CheckInStatus.success => FontAwesomeIcons.circleCheck,

            CheckInStatus.fail => FontAwesomeIcons.circleXmark,

            CheckInStatus.pending => FontAwesomeIcons.circleDot,
          },
          size: 38,
          color: isCurrentUser
              ? const Color.fromARGB(255, 128, 227, 209)
              : color,
        ),
      ),
    );
  }
}
