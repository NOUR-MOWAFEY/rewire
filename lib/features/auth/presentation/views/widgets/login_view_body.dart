import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/constants.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/auth/presentation/views/widgets/auth_footer.dart';
import 'package:rewire/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:rewire/features/auth/presentation/views/widgets/greetin_section.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewPadding(context),
      child: ListView(
        children: [
          const SizedBox(height: 60),
          const GreetingSection(
            title: 'Welcome back',
            subtitle: 'Sign in to continue rewiring',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .22),

          const CustomTextFormField(
            title: 'Email',
            icon: FontAwesomeIcons.envelope,
          ),
          const SizedBox(height: 12),
          const CustomTextFormField(
            title: 'Password',
            isPassword: true,
            icon: FontAwesomeIcons.lock,
          ),
          const SizedBox(height: 20),

          const CustomButton(title: 'Login'),
          const SizedBox(height: 12),

          const AuthFooter(
            text: 'Don\'t have an account?  ',
            buttonTitle: 'Register',
            navigateTo: AppRouter.registerView,
          ),
        ],
      ),
    );
  }
}
