import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/widgets/custom_circular_loading.dart';
import 'package:rewire/features/auth/presentation/view_model/user_cubit/user_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/profile_view/widgets/profile_view_app_bar.dart';
import 'package:rewire/features/home/presentation/views/profile_view/widgets/user_data_fields.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_avatar.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_update_button.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({
    super.key,
    required this.viewModel,
    required this.nameController,
    required this.emailController,
  });

  final ProfileViewModel viewModel;
  final TextEditingController nameController;
  final TextEditingController emailController;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      color: AppColors.white,
      backgroundColor: AppColors.transparentPrimary,
      onRefresh: () async {
        final state = context.read<UserCubit>().state;
        if (state is UserSuccess) {
          await widget.viewModel.loadProfileImage(
            imageUpdatedAt: state.user.imageUpdatedAt,
          );
        } else {
          await widget.viewModel.loadProfileImage();
        }
      },
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            return AnimatedBuilder(
              animation: widget.viewModel,
              builder: (BuildContext context, Widget? child) => ListView(
                children: [
                  ProfileViewAppBar(user: state.user),
                  const SizedBox(height: 42),

                  CustomAvatar(
                    viewModel: widget.viewModel,
                    imageType: ImageType.user,
                  ),
                  const SizedBox(height: 28),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: UserDataFields(
                      user: state.user,
                      nameController: widget.nameController,
                      emailController: widget.emailController,
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
                        await context.read<UserCubit>().updateName(
                          widget.nameController.text,
                        );
                        if (mounted) {
                          setState(() {
                            isUpdating = false;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CustomCircularLoading(size: 32));
        },
      ),
    );
  }
}
