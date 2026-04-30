import 'package:flutter/material.dart';
import '../../../../../core/services/firebase_auth_service.dart';
import '../../../../../core/services/supabase_storage_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../view_model/profile_view_model.dart';
import '../../../../../core/widgets/custom_avatar.dart';

class UserImageBuilder extends StatefulWidget {
  const UserImageBuilder({super.key});

  @override
  State<UserImageBuilder> createState() => _UserImageBuilderState();
}

class _UserImageBuilderState extends State<UserImageBuilder> {
  late ProfileViewModel viewModel;

  @override
  void initState() {
    viewModel = ProfileViewModel(
      storageService: getIt.get<SupabaseStorageService>(),
      authService: getIt.get<FirebaseAuthService>(),
      imageType: ImageType.user,
    );

    viewModel.loadProfileImage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAvatar(viewModel: viewModel, imageType: ImageType.user);
  }
}
