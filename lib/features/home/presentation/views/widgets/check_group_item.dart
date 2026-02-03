import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/widgets/check_icon_button.dart';

class CheckGroupItem extends StatelessWidget {
  const CheckGroupItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, bottom: 4),
          child: Text('2 / 11 / 2025', style: AppStyles.textStyle14),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 85,
          width: 80,
          decoration: BoxDecoration(
            color: AppColors.transparentPrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckIconButton(icon: FontAwesomeIcons.circleCheck),
              VerticalDivider(
                color: AppColors.secondary,
                indent: 10,
                endIndent: 10,
              ),
              CheckIconButton(),
              VerticalDivider(
                color: AppColors.secondary,
                indent: 10,
                endIndent: 10,
              ),
              CheckIconButton(),
              VerticalDivider(
                color: AppColors.secondary,
                indent: 10,
                endIndent: 10,
              ),
              CheckIconButton(),
              VerticalDivider(
                color: AppColors.secondary,
                indent: 10,
                endIndent: 10,
              ),
              CheckIconButton(),
            ],
          ),
        ),
      ],
    );
  }
}
