import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/utils/validator.dart';
import 'custom_text_form_field.dart';

class LoginDataSection extends StatelessWidget {
  const LoginDataSection({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          title: 'Email',
          icon: FontAwesomeIcons.envelope,
          inputType: InputType.email,
          controller: emailController,
        ),
        const SizedBox(height: 12),
        CustomTextFormField(
          title: 'Password',
          isPassword: true,
          icon: FontAwesomeIcons.lock,
          inputType: InputType.password,
          isLastOne: true,
          controller: passwordController,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
