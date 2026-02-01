import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../view_model/auth_cubit/auth_cubit.dart';
import 'auth_footer.dart';
import 'greetin_section.dart';
import 'register_data_section.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.registerKey, required this.confirmPasswordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final GlobalKey<FormState> registerKey;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewPadding(context),
      child: Form(
        key: registerKey,
        child: ListView(
          children: [
            const SizedBox(height: 30),
            const GreetingSection(
              title: 'Create account',
              subtitle: 'Start rewiring your habits today',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .15),

            RegisterDataSection(
              nameController: nameController,
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
            ),

            CustomButton(
              title: 'Register',
              onPressed: () async {
                if (!registerKey.currentState!.validate()) {
                  return;
                }
                await BlocProvider.of<AuthCubit>(context).register(
                  emailController.text,
                  passwordController.text,
                  nameController.text,
                );
              },
            ),
            const SizedBox(height: 12),

            const AuthFooter(
              text: 'Already have an account?  ',
              buttonTitle: 'Login',
              navigateTo: '/',
            ),
          ],
        ),
      ),
    );
  }
}
