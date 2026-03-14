import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';

import '../../../../data/models/group_model.dart';

class GroupItemImage extends StatefulWidget {
  const GroupItemImage({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  State<GroupItemImage> createState() => _GroupItemImageState();
}

class _GroupItemImageState extends State<GroupItemImage> {
  late ProfileViewModel viewModel;
  late SupabaseStorageService storageService;
  late FirebaseAuthService authService;

  @override
  void initState() {
    super.initState();

    storageService = getIt.get<SupabaseStorageService>();

    authService = getIt.get<FirebaseAuthService>();

    viewModel = ProfileViewModel(
      storageService: storageService,
      authService: authService,
      imageType: ImageType.group,
    );

    viewModel.loadGroupImage(
      widget.groupModel.id,
      imageUpdatedAt: widget.groupModel.imageUpdatedAt,
    );
  }

  @override
  void didUpdateWidget(covariant GroupItemImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.groupModel.imageUpdatedAt !=
        oldWidget.groupModel.imageUpdatedAt) {
      viewModel.loadGroupImage(
        widget.groupModel.id,
        imageUpdatedAt: widget.groupModel.imageUpdatedAt,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (BuildContext context, Widget? child) {
        return Container(
          height: 55,
          width: 55,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.transparentPrimary,
          ),
          child: ClipOval(
            child: viewModel.imageFile != null
                ? Image.file(viewModel.imageFile!, fit: BoxFit.cover)
                : viewModel.imageUrl != null
                ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: viewModel.imageUrl!,
                    placeholder: (context, url) =>
                        const GroupProfileDefaultAvatar(),
                    errorWidget: (context, url, error) =>
                        const GroupProfileDefaultAvatar(),
                  )
                : const GroupProfileDefaultAvatar(),
          ),
        );
      },
    );
  }
}

class GroupProfileDefaultAvatar extends StatelessWidget {
  const GroupProfileDefaultAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.group_rounded,
      size: 32,
      color: Color.fromARGB(218, 224, 224, 224),
    );
  }
}
