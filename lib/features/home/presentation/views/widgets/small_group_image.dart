import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';

class SmallGroupImage extends StatefulWidget {
  const SmallGroupImage({
    super.key,
    required this.groupId,
    this.imageUpdatedAt,
    this.radius = 20,
  });

  final String groupId;
  final int? imageUpdatedAt;
  final double radius;

  @override
  State<SmallGroupImage> createState() => _SmallGroupImageState();
}

class _SmallGroupImageState extends State<SmallGroupImage> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _initViewModel();
  }

  void _initViewModel() {
    viewModel = ProfileViewModel(
      storageService: getIt.get<SupabaseStorageService>(),
      authService: getIt.get<FirebaseAuthService>(),
      imageType: ImageType.group,
    );
    viewModel.loadGroupImage(widget.groupId, imageUpdatedAt: widget.imageUpdatedAt);
  }

  @override
  void didUpdateWidget(covariant SmallGroupImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.groupId != oldWidget.groupId ||
        widget.imageUpdatedAt != oldWidget.imageUpdatedAt) {
      viewModel.loadGroupImage(widget.groupId, imageUpdatedAt: widget.imageUpdatedAt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        return CircleAvatar(
          radius: widget.radius,
          backgroundColor: AppColors.transparentPrimary,
          child: ClipOval(
            child: viewModel.imageFile != null
                ? Image.file(
                    viewModel.imageFile!,
                    width: widget.radius * 2,
                    height: widget.radius * 2,
                    fit: BoxFit.cover,
                  )
                : viewModel.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: viewModel.imageUrl!,
                    width: widget.radius * 2,
                    height: widget.radius * 2,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildDefaultIcon(),
                    errorWidget: (context, url, error) => _buildDefaultIcon(),
                  )
                : _buildDefaultIcon(),
          ),
        );
      },
    );
  }

  Widget _buildDefaultIcon() {
    return Icon(
      Icons.group_rounded,
      size: widget.radius * 1.2,
      color: const Color.fromARGB(213, 224, 224, 224),
    );
  }
}
