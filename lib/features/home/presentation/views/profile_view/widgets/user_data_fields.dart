import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_underline_text_field.dart';

class UserDataFields extends StatelessWidget {
  const UserDataFields({
    super.key,
    required this.user,
    required this.nameController,
    required this.emailController,
  });

  final UserModel user;
  final TextEditingController nameController;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email address: ', style: AppStyles.textStyle14),
        CustomUnderlineTextField(
          hintText: user.email,
          controller: emailController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
          isEnabled: false,
        ),

        const SizedBox(height: 4),

        Text(
          'You can\'t change your email address.',
          style: AppStyles.textStyle12.copyWith(
            color: Colors.red.withValues(alpha: .7),
          ),
        ),

        const SizedBox(height: 24),

        Text('Full name: ', style: AppStyles.textStyle14),
        CustomUnderlineTextField(
          hintText: user.name,
          controller: nameController,
        ),
      ],
    );
  }
}
