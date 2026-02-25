import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/create_group_cubit/create_group_cubit.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_view_body.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  late TextEditingController groupNameController;
  late TextEditingController groupPasswordController;
  late GlobalKey<FormState> groupNameKey;
  late FirestoreService _firestoreService;
  late User? _user;

  @override
  void initState() {
    super.initState();
    setInitialValues();
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
        create: (context) => CreateGroupCubit(_firestoreService, _user),
        child: CreateGroupViewBody(
          groupNameController: groupNameController,
          groupNameKey: groupNameKey,
          groupPasswordController: groupPasswordController,
        ),
      ),
    );
  }

  void setInitialValues() {
    groupNameController = TextEditingController();
    groupPasswordController = TextEditingController();
    groupNameKey = GlobalKey<FormState>();
    _firestoreService = getIt.get<FirestoreService>();
    _user = context.read<AuthCubit>().getUser();
  }
}
