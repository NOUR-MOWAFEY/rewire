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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(AppRouter.homeView, extra: state.user);
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
                  onPressed: () async {
                    if (!loginKey.currentState!.validate()) {
                      return;
                    }
                    await BlocProvider.of<AuthCubit>(
                      context,
                    ).login(emailController.text, passwordController.text);
                  },
                ),
                const SizedBox(height: 12),

                AuthFooter(
                  text: 'Don\'t have an account?',
                  buttonTitle: 'Register',
                  onTap: () {
                    context.push(AppRouter.registerView).then((value) {
                      emailController.clear();
                      passwordController.clear();
                      loginKey.currentState?.reset();
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
