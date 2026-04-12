import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/auth/presentation/view_model/user_cubit/user_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/join_group_cubit/join_group_cubit.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/join_group_alert_dialog.dart';

class HomeViewAppBar extends StatelessWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              String name = '';
              if (state is UserSuccess) {
                name = state.user.name.split(RegExp(r'\s+'))[0];
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: PageScrollPhysics(),
                child: Text('Hi, $name', style: AppStyles.textStyle28),
              );
            },
          ),
        ),

        const SizedBox(width: 4),

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
