import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/constants.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/auth/presentation/views/widgets/auth_footer.dart';
import 'package:rewire/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:rewire/features/auth/presentation/views/widgets/greetin_section.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewPadding(context),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          const GreetingSection(
            title: 'Create account',
            subtitle: 'Start rewiring your habits today',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .15),

          const CustomTextFormField(title: 'Name', icon: FontAwesomeIcons.user),
          const SizedBox(height: 12),

          const CustomTextFormField(
            title: 'Email',
            icon: FontAwesomeIcons.envelope,
          ),
          const SizedBox(height: 12),

          const CustomTextFormField(
            title: 'Password',
            isPassword: true,
            icon: Icons.lock_outline_rounded,
          ),
          const SizedBox(height: 12),
          const CustomTextFormField(
            title: 'Confirm password',
            isPassword: true,
            icon: Icons.lock_outline_rounded,
          ),
          const SizedBox(height: 20),

          const CustomButton(title: 'Register'),
          const SizedBox(height: 12),

          const AuthFooter(
            text: 'Already have an account?  ',
            buttonTitle: 'Login',
            navigateTo: '/',
          ),
        ],
      ),
    );
  }
}
