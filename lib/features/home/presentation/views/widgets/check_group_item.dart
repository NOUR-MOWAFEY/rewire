import 'package:flutter/material.dart';
import 'package:rewire/features/home/presentation/views/widgets/check_icon_button.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class CheckGroupItem extends StatelessWidget {
  const CheckGroupItem({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 4),
          child: Text(date, style: AppStyles.textStyle14),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 85,
          width: 80,
          decoration: BoxDecoration(
            color: AppColors.transparentPrimary,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getCheckGroupItems(),
          ),
        ),
      ],
    );
  }
}

List<Widget> getCheckGroupItems() {
  final List<Widget> widgets = [];
  for (int i = 0; i < members.length; i++) {
    widgets.add(const CheckIconButton());
    if (i == members.length - 1) {
      continue;
    }
    widgets.add(
      const VerticalDivider(
        color: AppColors.secondary,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
  return widgets;
}

const List<String> members = ['1', '2', '3', '4', '5'];
