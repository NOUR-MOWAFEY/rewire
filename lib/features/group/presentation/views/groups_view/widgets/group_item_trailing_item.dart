import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';

class GroupItemTrailingIcon extends StatelessWidget {
  const GroupItemTrailingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Icon(FontAwesomeIcons.angleRight, color: AppColors.white),
    );
  }
}
