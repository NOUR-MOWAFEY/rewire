import 'package:flutter/material.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/group/data/models/group_model.dart';
import 'package:rewire/features/profile_view/presentation/view_model/profile_view_model.dart';
import 'package:rewire/core/widgets/custom_avatar.dart';


class GroupImageBuilder extends StatefulWidget {
  const GroupImageBuilder({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  State<GroupImageBuilder> createState() => _GroupImageBuilderState();
}

class _GroupImageBuilderState extends State<GroupImageBuilder> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewModel(
      storageService: getIt.get<SupabaseStorageService>(),
      authService: getIt.get<FirebaseAuthService>(),
      imageType: ImageType.group,
    );

    viewModel.loadGroupImage(widget.groupModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (BuildContext context, Widget? child) {
        return CustomAvatar(
          viewModel: viewModel,
          imageType: ImageType.group,
          groupId: widget.groupModel.id,
        );
      },
    );
  }
}
