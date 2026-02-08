import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_button.dart';

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
          ),
          const SizedBox(height: 8),
          const Text(
            'Message: Hello from test version of the app',
            style: AppStyles.textStyle16,
          ),
          const SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              // color: AppColors.primary,
              border: Border.all(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CheckIconbuttonForPopupMenu(icon: FontAwesomeIcons.circleCheck),
                CheckIconbuttonForPopupMenu(icon: FontAwesomeIcons.circleDot),
                CheckIconbuttonForPopupMenu(icon: FontAwesomeIcons.circleXmark),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: AlignmentGeometry.bottomRight,
            child: CustomButton(
              width: 150,
              height: 40,
              title: 'Leave a message',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class CheckIconbuttonForPopupMenu extends StatelessWidget {
  const CheckIconbuttonForPopupMenu({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, size: 40, color: AppColors.white),
    );
  }
}
