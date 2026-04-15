import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/data/models/group_info_view_data.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/group_settings_view_body.dart';

class GroupSettingsView extends StatefulWidget {
  const GroupSettingsView({super.key, required this.groupDataModel});

  final GroupDataModel groupDataModel;

  @override
  State<GroupSettingsView> createState() => _GroupSettingsViewState();
}

class _GroupSettingsViewState extends State<GroupSettingsView> {
  late final ProfileViewModel viewModel;
  late final TextEditingController groupNameController;
  late final TextEditingController groupPasswordController;
  late final GlobalKey<FormState> updateGroupDataKey;

  @override
  void initState() {
    super.initState();
    initializeSettingsViewBodyData();
  }

  @override
  void dispose() {
    groupNameController.dispose();
    groupPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      viewBody: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: widget.groupDataModel.membersCubit),
          BlocProvider.value(
            value: widget.groupDataModel.groupCubit
              ..getJoinCode(widget.groupDataModel.groupModel.id),
          ),
        ],
        child: GroupSettingsViewBody(
          viewModel: viewModel,
          groupModel: widget.groupDataModel.groupModel,
          groupNameController: groupNameController,
          groupPasswordController: groupPasswordController,
          updateGroupDataKey: updateGroupDataKey,
        ),
      ),
    );
  }

  void initializeSettingsViewBodyData() {
    viewModel = ProfileViewModel(
      imageType: ImageType.group,
      storageService: getIt.get<SupabaseStorageService>(),
      authService: getIt.get<FirebaseAuthService>(),
    );

    groupNameController = TextEditingController()
      ..text = widget.groupDataModel.groupModel.name;
    groupPasswordController = TextEditingController();
    updateGroupDataKey = GlobalKey<FormState>();

    viewModel.loadGroupImage(widget.groupDataModel.groupModel.id);
  }
}
