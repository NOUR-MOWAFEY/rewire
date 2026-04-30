import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/services/supabase_storage_service.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../core/widgets/custom_avatar.dart';
import '../../../../../../core/widgets/custom_circular_loading.dart';
import '../../../../../profile_view/data/models/user_model.dart';

class MemberItemImage extends StatelessWidget {
  const MemberItemImage({super.key, required this.user, this.radius = 20});
  final UserModel user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    // Fallback widget for when there's no image
    Widget fallback() {
      final name = user.name.trim();
      if (name.isNotEmpty) {
        return CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.primary,
          child: Text(
            name[0].toUpperCase(),
            style: AppStyles.textStyle16.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: radius * 0.8,
            ),
          ),
        );
      }
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.primary.withValues(alpha: 0.5),
        child: const UserProfileDefaultAvatar(size: 22),
      );
    }

    // If we have no timestamp, we assume no image is set yet
    if (user.imageUpdatedAt == null) {
      return fallback();
    }

    final storageService = getIt.get<SupabaseStorageService>();
    final imageUrl = storageService.getUserImageUrl(
      user.uid,
      imageUpdatedAt: user.imageUpdatedAt,
    );

    return Container(
      height: radius * 2,
      width: radius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.transparentPrimary,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => CustomCircularLoading(size: radius),
          errorWidget: (context, url, error) => fallback(),
        ),
      ),
    );
  }
}
