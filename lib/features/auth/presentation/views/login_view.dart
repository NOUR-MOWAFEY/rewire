import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import 'widgets/login_view_body.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> loginKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
          colors: AppColors.gradientColors,
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: LoginViewBody(
            emailController: emailController,
            passwordController: passwordController,
            loginKey: loginKey,
          ),
        ),
      ),
    );
  }
}
