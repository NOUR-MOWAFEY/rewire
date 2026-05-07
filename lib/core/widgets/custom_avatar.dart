import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/services/firestore/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/user_default_avatar.dart';

import '../../features/profile_view/presentation/view_model/profile_view_model.dart';
import '../utils/app_colors.dart';
import '../utils/show_toastification.dart';
import 'custom_circular_loading.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.viewModel,
    required this.imageType,
    this.groupId,
    this.size = 130,
  });

  final ProfileViewModel viewModel;
  final ImageType imageType;
  final String? groupId;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AbsorbPointer(
        absorbing: viewModel.isLoading,
        child: AnimatedBuilder(
          animation: viewModel,
          builder: (BuildContext context, Widget? child) => Container(
            height: size,
            width: size,
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
                  final fireStoreService = getIt.get<FirestoreService>();

                  try {
                    if (imageType == ImageType.group && groupId != null) {
                      fireStoreService.updateGroupImageTimestamp(groupId!);
                    } else if (imageType == ImageType.user) {
                      final userId = viewModel.authService
                          .getCurrentUser()!
                          .uid;
                      fireStoreService.updateUserImageTimestamp(userId);
                    }
                  } catch (e) {
                    // Ignore errors
                  }

                  if (!context.mounted) return;
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
                  _ImageBuilder(viewModel: viewModel),
                  const Positioned(
                    bottom: 5,
                    right: 5,
                    child: _ImagePlusIcon(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageBuilder extends StatelessWidget {
  const _ImageBuilder({required this.viewModel});

  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: viewModel.imageFile != null
          ? Image.file(viewModel.imageFile!, fit: BoxFit.cover)
          : viewModel.imageUrl != null
          ? CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: viewModel.imageUrl!,
              placeholder: (context, url) =>
                  const CustomCircularLoading(size: 28),
              errorWidget: (context, url, error) => const UserDefaultAvatar(),
            )
          : const UserDefaultAvatar(),
    );
  }
}

class _ImagePlusIcon extends StatelessWidget {
  const _ImagePlusIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 28,
      decoration: BoxDecoration(
        color: AppColors.transparentPrimary,
        shape: BoxShape.circle,
      ),

      child: const Icon(
        FontAwesomeIcons.plus,
        size: 14,
        color: AppColors.white,
      ),
    );
  }
}
