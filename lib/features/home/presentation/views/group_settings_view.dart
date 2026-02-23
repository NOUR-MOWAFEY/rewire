import 'package:flutter/material.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/custom_back_button.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/group_settings_view_body.dart';

class GroupSettingsView extends StatefulWidget {
  const GroupSettingsView({super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,

        title: Row(
          children: [
            const CustomBackButton(),
            const SizedBox(width: 8),
            Text(
              'ID: ',
              style: AppStyles.textStyle20.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'LRG9JC',
              style: AppStyles.textStyle20.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      viewBody: GroupSettingsViewBody(viewModel: viewModel),
    );
  }
}
