import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/view_model/habit_cubit/habit_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/create_group_view_body.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  late TextEditingController groupNameController;
  late GlobalKey<FormState> groupNameKey;

  @override
  void initState() {
    super.initState();
    groupNameController = TextEditingController();
    groupNameKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      viewBody: BlocProvider(
        create: (context) => HabitCubit(
          getIt.get<FirestoreService>(),
          getIt.get<FirebaseAuthService>().getCurrentUser(),
        ),
        child: CreateGroupViewBody(
          groupNameController: groupNameController,
          groupNameKey: groupNameKey,
        ),
      ),
    );
  }
}
