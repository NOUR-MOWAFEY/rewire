import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popover/popover.dart';

import '../../../../../core/utils/app_colors.dart';
import '../group_details_view/widgets/popup_menu.dart';

class CheckIconButton extends StatelessWidget {
  const CheckIconButton({
    super.key,
    this.color = AppColors.white,
    this.icon = FontAwesomeIcons.circleDot,
    required this.index,
  });
  final Color? color;
  final IconData? icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => PopUpMenu(isFirstOne: index == 0),
          direction: PopoverDirection.bottom,
          height: index == 0 ? 210 : 160,
          width: 280,
          radius: 28,
          arrowDyOffset: -4,
          backgroundColor: AppColors.alertDialogColor,
        );
      },
      icon: Icon(
        icon,
        size: 38,
        color: index == 0 ? const Color.fromARGB(255, 128, 227, 209) : color,
      ),
    );
  }
}
