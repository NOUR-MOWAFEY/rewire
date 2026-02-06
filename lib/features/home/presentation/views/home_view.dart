import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/view_model/habit_cubit/habit_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/create_group_modal_bottom_sheet_body.dart';

import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      showFloatingActionButton: true,
      floatingButtonOnPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => BlocProvider(
            create: (context) =>
                HabitCubit(getIt.get<FirestoreService>(), user),
            child: const CreateGroupModalBottomSheetBody(),
          ),
        );
      },
      viewBody: const HomeViewBody(),
    );
  }
}
