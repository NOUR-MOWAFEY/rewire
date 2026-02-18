import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_avatar.dart';

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
            const SizedBox(height: 48),
            CustomAvatar(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
}
