import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/services/firebase_auth_service.dart';
import '../../../../../../core/services/supabase_storage_service.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../profile_view/presentation/view_model/profile_view_model.dart';
import '../../../../data/models/group_model.dart';

class GroupItemImage extends StatefulWidget {
  const GroupItemImage({super.key, required this.groupModel, this.size});

  final GroupModel groupModel;
  final double? size;

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
          height: widget.size ?? 55,
          width: widget.size ?? 55,
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
                        GroupProfileDefaultAvatar(size: widget.size),
                    errorWidget: (context, url, error) =>
                        GroupProfileDefaultAvatar(size: widget.size),
                  )
                : GroupProfileDefaultAvatar(size: widget.size),
          ),
        );
      },
    );
  }
}

class GroupProfileDefaultAvatar extends StatelessWidget {
  const GroupProfileDefaultAvatar({super.key, required this.size});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.group_rounded,
      size: size != null ? size! * 0.6 : 32,
      color: Color.fromARGB(218, 224, 224, 224),
    );
  }
}
