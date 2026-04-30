import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'login_form.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import 'auth_footer.dart';
import 'auth_header.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewPadding(context),
      child: ListView(
        children: [
          const SizedBox(height: 85),

          const AuthHeader(
            title: 'Welcome back',
            subtitle: 'Sign in to continue rewiring',
          ),

          const SizedBox(height: 200),

          const LoginForm(),

          const SizedBox(height: 12),

          AuthFooter(
            text: 'Don\'t have an account?',
            buttonTitle: 'Register',
            onTap: () {
              context.push(AppRouter.registerView);
            },
          ),
        ],
      ),
    );
  }
}
