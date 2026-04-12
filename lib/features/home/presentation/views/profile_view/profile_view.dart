import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/auth/presentation/view_model/user_cubit/user_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/profile_view/widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileViewModel viewModel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewModel(
      imageType: ImageType.user,
      storageService: getIt.get<SupabaseStorageService>(),
      authService: getIt.get<FirebaseAuthService>(),
    );
    final userState = context.read<UserCubit>().state;
    if (userState is UserSuccess) {
      nameController.text = userState.user.name;
      emailController.text = userState.user.email;
      viewModel.loadProfileImage(imageUpdatedAt: userState.user.imageUpdatedAt);
    } else {
      viewModel.loadProfileImage();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          if (nameController.text.isEmpty) {
            nameController.text = state.user.name;
          }
          if (emailController.text.isEmpty) {
            emailController.text = state.user.email;
          }
          viewModel.loadProfileImage(imageUpdatedAt: state.user.imageUpdatedAt);
        }
      },
      child: ViewBackGroundContainer(
        viewBody: ProfileViewBody(
          viewModel: viewModel,
          nameController: nameController,
          emailController: emailController,
        ),
      ),
    );
  }
}
