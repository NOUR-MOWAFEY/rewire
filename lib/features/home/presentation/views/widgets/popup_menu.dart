import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewire/core/utils/app_styles.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset('assets/images/pic.svg'),
              ),
              const SizedBox(width: 8),
              Text(
                'Nour Mowafey',
                style: AppStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Message: ezakom 3amlen ah elnaharda',
            style: AppStyles.textStyle16,
          ),
        ],
      ),
    );
  }
}
