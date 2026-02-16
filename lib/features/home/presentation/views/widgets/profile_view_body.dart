import 'package:flutter/material.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_avatar.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewModel(
      storageService: getIt.get<SupabaseStorageService>(),
      authService: getIt.get<FirebaseAuthService>(),
    );
    viewModel.loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      color: AppColors.white,
      backgroundColor: AppColors.transparentPrimary,
      onRefresh: () async =>
          await viewModel.loadImage().then((value) => setState(() {})),

      child: AnimatedBuilder(
        animation: viewModel,
        builder: (BuildContext context, Widget? child) => ListView(
          children: [
            const SizedBox(height: 48),

            CustomAvatar(
              imageFile: viewModel.imageFile,
              imageUrl: viewModel.imageUrl,
            ),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130),
              child: CustomButton(
                title: viewModel.isLoading ? 'Uploading...' : 'Upload Image',
                height: 40,
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        await viewModel.pickImage();
                        final success = await viewModel.uploadImage();

                        if (!context.mounted) return;
                        if (success == null) return;

                        if (success) {
                          ShowToastification.success(
                            context,
                            'Image uploaded successfully',
                          );
                        } else {
                          ShowToastification.failure(
                            context,
                            'Upload failed. Please check your connection and try again.',
                          );
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
