import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/views/profile_view/widgets/custom_logout_button.dart';

class ProfileViewAppBar extends StatelessWidget {
  const ProfileViewAppBar({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              'Joined: ${DateFormat('dd MMM, yyyy').format(user.joinedAt)}',
              style: AppStyles.textStyle18.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const CustomLogoutButton(),
        ],
      ),
    );
  }
}
