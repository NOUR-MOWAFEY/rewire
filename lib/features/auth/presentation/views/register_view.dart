import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/view_background_container.dart';
import 'widgets/register_view_body.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;
  late GlobalKey<FormState> registerKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    registerKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomBackButton(),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      viewBody: RegisterViewBody(
        emailController: emailController,
        passwordController: passwordController,
        nameController: nameController,
        registerKey: registerKey,
        confirmPasswordController: confirmPasswordController,
      ),
    );
  }
}
