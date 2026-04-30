import 'package:flutter/material.dart';
import '../../../../../core/services/supabase_storage_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../profile_view/data/models/user_model.dart';

class LeaderboardItemMemberImage extends StatelessWidget {
  const LeaderboardItemMemberImage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primary,
      backgroundImage: user.imageUpdatedAt != null
          ? NetworkImage(
              getIt.get<SupabaseStorageService>().getUserImageUrl(
                user.uid,
                imageUpdatedAt: user.imageUpdatedAt,
              ),
            )
          : null,
      child: user.imageUpdatedAt == null
          ? Text(
              user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }
}
