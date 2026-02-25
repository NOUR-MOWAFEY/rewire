import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/join_group_cubit/join_group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/group_settings_app_bar.dart';
import 'package:rewire/features/home/presentation/views/widgets/group_settings_view_body.dart';

class GroupSettingsView extends StatefulWidget {
  const GroupSettingsView({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  State<GroupSettingsView> createState() => _GroupSettingsViewState();
}

class _GroupSettingsViewState extends State<GroupSettingsView> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ProfileViewModel(
      storageService: getIt.get<SupabaseStorageService>(),
      authService: getIt.get<FirebaseAuthService>(),
    );

    BlocProvider.of<JoinGroupCubit>(context).getJoinCode(widget.groupModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: GroupSettingsAppBar(),
      viewBody: GroupSettingsViewBody(
        viewModel: viewModel,
        groupModel: widget.groupModel,
      ),
    );
  }
}
