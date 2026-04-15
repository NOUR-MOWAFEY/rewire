import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_underline_text_field.dart';

class UserDataFields extends StatelessWidget {
  const UserDataFields({
    super.key,
    required this.emailController,
    required this.nameController,
  });

  final TextEditingController emailController;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,

      children: [
        const Text('Email address: ', style: AppStyles.textStyle14),

        CustomUnderlineTextField(
          hintText: 'user@email.com',
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

        const Text('Full name: ', style: AppStyles.textStyle14),
        CustomUnderlineTextField(
          hintText: 'username',
          controller: nameController,
        ),
      ],
    );
  }
}
