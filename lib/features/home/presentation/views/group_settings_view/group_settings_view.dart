import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/delete_group_cubit/delete_group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/join_group_cubit/join_group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/group_settings_view_body.dart';

class GroupSettingsView extends StatefulWidget {
  const GroupSettingsView({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  State<GroupSettingsView> createState() => _GroupSettingsViewState();
}

class _GroupSettingsViewState extends State<GroupSettingsView> {
  late final SupabaseStorageService _supabaseStorageService;
  late final FirestoreService _firestoreService;
  late final ProfileViewModel viewModel;
  late final TextEditingController groupNameController;
  late final TextEditingController groupPasswordController;
  late final GlobalKey<FormState> updateGroupDataKey;

  @override
  void initState() {
    super.initState();
    initializeSettingsViewBodyData();

    BlocProvider.of<JoinGroupCubit>(context).getJoinCode(widget.groupModel.id);
  }

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
    groupPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      viewBody: BlocProvider(
        create: (context) => DeleteGroupCubit(
          _firestoreService,
          supabaseStorageService: _supabaseStorageService,
        ),

        child: GroupSettingsViewBody(
          viewModel: viewModel,
          groupModel: widget.groupModel,
          groupNameController: groupNameController,
          groupPasswordController: groupPasswordController,
          updateGroupDataKey: updateGroupDataKey,
        ),
      ),
    );
  }

  void initializeSettingsViewBodyData() {
    _firestoreService = getIt.get<FirestoreService>();
    _supabaseStorageService = getIt.get<SupabaseStorageService>();

    viewModel = ProfileViewModel(
      imageType: ImageType.group,
      storageService: getIt.get<SupabaseStorageService>(),
      authService: getIt.get<FirebaseAuthService>(),
    );

    groupNameController = TextEditingController();
    groupPasswordController = TextEditingController();
    updateGroupDataKey = GlobalKey<FormState>();

    viewModel.loadGroupImage(widget.groupModel.id);
  }
}
