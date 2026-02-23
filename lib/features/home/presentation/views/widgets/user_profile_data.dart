import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/widgets/profile_custom_text_field.dart';

class UserProfileViewData extends StatelessWidget {
  const UserProfileViewData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        Text('Full name: ', style: AppStyles.textStyle14),
        ProfileCustomTextField(hintText: 'Nour Mowafey'),
        SizedBox(height: 24),
        Text('Email address: ', style: AppStyles.textStyle14),
        ProfileCustomTextField(
          hintText: 'nourmowafey82@gmail.com',
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
