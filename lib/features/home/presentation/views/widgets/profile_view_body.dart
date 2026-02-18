import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_avatar.dart';
import 'package:rewire/features/home/presentation/views/widgets/profile_view_app_bar.dart';
import 'package:rewire/features/home/presentation/views/widgets/user_profile_data.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.viewModel});
  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      color: AppColors.white,
      backgroundColor: AppColors.transparentPrimary,
      onRefresh: () async => await viewModel.loadImage(),

      child: AnimatedBuilder(
        animation: viewModel,
        builder: (BuildContext context, Widget? child) => ListView(
          children: [
            const ProfileViewAppBar(),
            const SizedBox(height: 42),

            CustomAvatar(viewModel: viewModel),
            const SizedBox(height: 28),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: UserProfileViewData(),
            ),

            Align(
              alignment: .centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 32,
                ),
                child: CustomButton(
                  title: 'Save',
                  width: 90,
                  height: 40,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
