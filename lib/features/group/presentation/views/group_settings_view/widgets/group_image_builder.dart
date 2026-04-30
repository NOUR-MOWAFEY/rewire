import 'package:flutter/material.dart';

import '../../../../../../core/services/firebase_auth_service.dart';
import '../../../../../../core/services/supabase_storage_service.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../core/widgets/custom_avatar.dart';
import '../../../../../profile_view/presentation/view_model/profile_view_model.dart';
import '../../../../data/models/group_model.dart';

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
