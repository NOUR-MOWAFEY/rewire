import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/services/firebase_auth_service.dart';
import '../../../../../../core/services/firestore_service.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../view_model/join_group_cubit/join_group_cubit.dart';
import 'join_group_alert_dialog.dart';

class GroupsViewAppBarButtons extends StatelessWidget {
  const GroupsViewAppBarButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          width: 90,
          height: 40,
          title: 'Create',
          onPressed: () {
            context.push(AppRouter.createGroupView);
          },
        ),

        const SizedBox(width: 6),

        CustomButton(
          width: 65,
          height: 40,
          title: 'join',
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) => JoinGroupCubit(
                  getIt.get<FirestoreService>(),
                  getIt.get<FirebaseAuthService>(),
                ),
                child: const JoinGroupAlertDialog(),
              ),
            );
          },
        ),
      ],
    );
  }
}
