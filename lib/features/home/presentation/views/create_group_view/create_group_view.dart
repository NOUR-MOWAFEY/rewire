import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/view_model/create_group_cubit/create_group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_button.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_view_body.dart';

class CreateGroupView extends StatelessWidget {
  const CreateGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateGroupCubit(
            getIt.get<FirestoreService>(),
            getIt.get<FirebaseAuthService>().getCurrentUser(),
          ),
        ),
        BlocProvider(create: (context) => MembersCubit()),
      ],
      child: const ViewBackGroundContainer(
        bottomNavigationBar: CreategroupButton(),
        viewBody: CreateGroupViewBody(),
      ),
    );
  }
}
