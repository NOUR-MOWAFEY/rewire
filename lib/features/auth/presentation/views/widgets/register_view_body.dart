import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/features/auth/presentation/views/widgets/register_form.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import 'auth_footer.dart';
import 'auth_header.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewPadding(context),
      child: ListView(
        children: [
          const SizedBox(height: 30),

          const AuthHeader(
            title: 'Create account',
            subtitle: 'Start rewiring your habits today',
          ),

          const SizedBox(height: 150),

          const RegisterForm(),

          const SizedBox(height: 12),

          AuthFooter(
            text: 'Already have an account?',
            buttonTitle: 'Login',
            onTap: () => context.go(AppRouter.loginView),
          ),
        ],
      ),
    );
  }
}
