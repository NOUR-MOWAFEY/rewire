import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/profile_view/widgets/custom_logout_button.dart';

class ProfileViewAppBar extends StatelessWidget {
  const ProfileViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Commitment score: 100%',
                style: AppStyles.textStyle18.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const CustomLogoutButton(),
      ],
    );
  }
}
