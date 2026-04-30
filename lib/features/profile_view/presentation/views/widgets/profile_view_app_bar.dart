import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/user_model.dart';
import 'custom_logout_button.dart';

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
