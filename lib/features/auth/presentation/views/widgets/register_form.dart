import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/show_toastification.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_circular_loading.dart';
import '../../view_model/auth_cubit/auth_cubit.dart';
import 'register_data_fields.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;
  late GlobalKey<FormState> registerKey;

  @override
  void initState() {
    _initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerKey,
      child: Column(
        children: [
          // text fields
          RegisterDataFields(
            nameController: nameController,
            emailController: emailController,
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
          ),

          // register button
          BlocConsumer<AuthCubit, AuthState>(
            listener: (BuildContext context, AuthState state) {
              if (state is AuthAccountCreated) {
                ShowToastification.success(
                  context,
                  'Account created Successfully',
                );
                context.go(AppRouter.loginView);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CustomButton(
                  color: Colors.grey,
                  child: CustomCircularLoading(size: 22),
                );
              }

              return CustomButton(
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
              );
            },
          ),
        ],
      ),
    );
  }

  void _initializeControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    registerKey = GlobalKey<FormState>();
  }

  void _disposeController() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
  }
}
