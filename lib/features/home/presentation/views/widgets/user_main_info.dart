import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewire/core/utils/app_styles.dart';

class UserMainInfo extends StatelessWidget {
  const UserMainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset('assets/images/pic.svg'),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nour Mowafey',
              style: AppStyles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('nourmowafey82@gmail.com', style: AppStyles.textStyle14),
          ],
        ),
      ],
    );
  }
}
