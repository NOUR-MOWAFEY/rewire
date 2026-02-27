import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.viewModel,
    required this.imageType,
    this.groupId,
  });

  final ProfileViewModel viewModel;
  final ImageType imageType;
  final String? groupId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AbsorbPointer(
        absorbing: viewModel.isLoading,
        child: Container(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.transparentPrimary,
          ),
          child: InkWell(
            onTap: () async {
              await viewModel.pickImage();
              final success = await viewModel.uploadImage(
                groupId: imageType == ImageType.group ? groupId : null,
              );

              if (!context.mounted) return;
              if (success == false) return;

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
            borderRadius: BorderRadius.circular(100),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipOval(
                  child: viewModel.imageFile != null
                      ? Image.file(viewModel.imageFile!, fit: BoxFit.cover)
                      : viewModel.imageUrl != null
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: viewModel.imageUrl!,
                          placeholder: (context, url) =>
                              const CustomLoading(size: 28),
                          errorWidget: (context, url, error) =>
                              const ProfileDefaultAvatar(),
                        )
                      : const ProfileDefaultAvatar(),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      color: AppColors.transparentPrimary,
                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      FontAwesomeIcons.plus,
                      size: 14,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDefaultAvatar extends StatelessWidget {
  const ProfileDefaultAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      FontAwesomeIcons.user,
      size: 48,
      color: Color.fromARGB(218, 224, 224, 224),
    );
  }
}
