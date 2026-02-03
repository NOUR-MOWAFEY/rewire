import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/show_toastification.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_loading.dart';
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
    required this.registerKey,
    required this.confirmPasswordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final GlobalKey<FormState> registerKey;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthSuccess) {
          context.go(AppRouter.loginView);
          ShowToastification.success(context, 'Account created Successfully');
        } else if (state is AuthFailure) {
          ShowToastification.failure(
            context,
            state.errMessage ?? 'Somthing went Wrong, Try again',
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const CustomLoading();
        }
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

                AuthFooter(
                  text: 'Already have an account?',
                  buttonTitle: 'Login',
                  onTap: () => context.go(AppRouter.loginView),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
