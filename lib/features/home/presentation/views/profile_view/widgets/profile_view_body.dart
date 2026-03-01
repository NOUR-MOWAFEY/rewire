import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/profile_view/widgets/profile_view_app_bar.dart';
import 'package:rewire/features/home/presentation/views/profile_view/widgets/user_data_fields.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_avatar.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_update_button.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.viewModel});
  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      color: AppColors.white,
      backgroundColor: AppColors.transparentPrimary,
      onRefresh: () async => await viewModel.loadProfileImage(),

      child: AnimatedBuilder(
        animation: viewModel,
        builder: (BuildContext context, Widget? child) => ListView(
          children: [
            const ProfileViewAppBar(),
            const SizedBox(height: 42),

            CustomAvatar(viewModel: viewModel, imageType: ImageType.user),
            const SizedBox(height: 28),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: UserDataFields(),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomUpdateButton(onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
