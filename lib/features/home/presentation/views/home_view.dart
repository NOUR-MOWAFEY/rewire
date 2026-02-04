import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/views/widgets/create_group_modal_bottom_sheet_body.dart';

import 'widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var firestoreService = getIt.get<FirestoreService>();
  var firebaseService = getIt.get<FirebaseService>();
  User? user;

  @override
  void initState() {
    super.initState();
    user = firebaseService.getCurrentUser();
    var habits = firestoreService.getUserHabits(user!.uid);
    log(user!.email!);
    log(habits.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      showFloatingActionButton: true,
      floatingButtonOnPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => const CreateGroupModalBottomSheetBody(),
        );
      },
      viewBody: const HomeViewBody(),
    );
  }
}
