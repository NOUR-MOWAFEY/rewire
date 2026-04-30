import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/show_toastification.dart';
import '../../../../../core/widgets/custom_circular_loading.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../view_model/auth_cubit/auth_cubit.dart';
import 'login_data_fields.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> loginKey;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginKey,

      child: Column(
        children: [
          // text fields
          LoginDataFields(
            emailController: emailController,
            passwordController: passwordController,
          ),

          // login button
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                context.go(AppRouter.mainNavigationView);
              } else if (state is AuthFailure) {
                ShowToastification.failure(
                  context,
                  state.errMessage ?? 'Somthing went Wrong, Try again',
                );
              }
            },

            builder: (context, state) {
              if (state is AuthLoading || state is AuthAuthenticated) {
                return const CustomButton(
                  color: Colors.grey,
                  child: CustomCircularLoading(size: 22),
                );
              }

              return CustomButton(
                title: 'Login',
                onPressed: () async {
                  if (!loginKey.currentState!.validate()) {
                    return;
                  }
                  await BlocProvider.of<AuthCubit>(
                    context,
                  ).login(emailController.text, passwordController.text);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
