import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/utils/app_styles.dart';

class PopUpMenuHeader extends StatelessWidget {
  const PopUpMenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset('assets/images/pic.svg'),
        ),

        const SizedBox(width: 8),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nour Mowafey',
              style: AppStyles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('2/10/2025', style: AppStyles.textStyle14),
          ],
        ),
      ],
    );
  }
}
