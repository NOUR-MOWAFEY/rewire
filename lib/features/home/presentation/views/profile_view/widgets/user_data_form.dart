import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/features/auth/presentation/view_model/user_cubit/user_cubit.dart';
import 'package:rewire/features/home/presentation/views/profile_view/widgets/user_data_fields.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_update_button.dart';

class UserDataForm extends StatefulWidget {
  const UserDataForm({super.key});

  @override
  State<UserDataForm> createState() => _UserDataFormState();
}

class _UserDataFormState extends State<UserDataForm> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();

    nameController.text = context.read<UserCubit>().currentUser?.name ?? '';
    emailController.text = context.read<UserCubit>().currentUser?.email ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: UserDataFields(
            emailController: emailController,
            nameController: nameController,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomUpdateButton(
            isLoading: isUpdating,
            onPressed: () async {
              setState(() {
                isUpdating = true;
              });
              await context.read<UserCubit>().updateName(nameController.text);
              if (mounted) {
                setState(() {
                  isUpdating = false;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
