import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popover/popover.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/presentation/views/widgets/popup_menu.dart';

class CheckIconButton extends StatelessWidget {
  const CheckIconButton({
    super.key,
    this.color = AppColors.white,
    this.icon = FontAwesomeIcons.circleDot,
  });
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => const PopUpMenu(),
          direction: PopoverDirection.bottom,
          height: 200,
          width: 250,
          backgroundColor: AppColors.transparentPrimary,
        );
      },
      icon: Icon(icon, size: 38, color: color),
    );
  }
}
