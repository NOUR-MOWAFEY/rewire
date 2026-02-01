import 'package:flutter/material.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'auth_footer.dart';
import 'greetin_section.dart';
import 'login_data_section.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.loginKey,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> loginKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewPadding(context),
      child: Form(
        key: loginKey,
        child: ListView(
          children: [
            const SizedBox(height: 60),
            const GreetingSection(
              title: 'Welcome back',
              subtitle: 'Sign in to continue rewiring',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .22),

            LoginDataSection(
              emailController: emailController,
              passwordController: passwordController,
            ),

            CustomButton(
              title: 'Login',
              onPressed: () {
                if (!loginKey.currentState!.validate()) {
                  return;
                }
              },
            ),
            const SizedBox(height: 12),

            const AuthFooter(
              text: 'Don\'t have an account?  ',
              buttonTitle: 'Register',
              navigateTo: AppRouter.registerView,
            ),
          ],
        ),
      ),
    );
  }
}
