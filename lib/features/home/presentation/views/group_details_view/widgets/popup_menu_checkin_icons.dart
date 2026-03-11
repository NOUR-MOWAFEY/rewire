import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      onPressed: () {},
      icon: Icon(icon, size: 36, color: AppColors.white),
    );
  }
}
