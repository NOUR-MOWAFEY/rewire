import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/utils/validator.dart';
import 'custom_text_form_field.dart';

class RegisterDataSection extends StatelessWidget {
  const RegisterDataSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          title: 'Name',
          icon: FontAwesomeIcons.user,
          controller: nameController,
          inputType: InputType.name,
        ),
        const SizedBox(height: 12),

        CustomTextFormField(
          title: 'Email',
          icon: FontAwesomeIcons.envelope,
          controller: emailController,
          inputType: InputType.email,
        ),
        const SizedBox(height: 12),

        CustomTextFormField(
          title: 'Password',
          isPassword: true,
          icon: Icons.lock_outline_rounded,
          controller: passwordController,
          inputType: InputType.password,
        ),
        const SizedBox(height: 12),
        CustomTextFormField(
          title: 'Confirm password',
          isPassword: true,
          icon: Icons.lock_outline_rounded,
          inputType: InputType.confirmPassword,
          controller: confirmPasswordController,
          isLastOne: true,
          passwordValue: passwordController.text,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
