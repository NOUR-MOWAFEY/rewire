import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/services/firebase_auth_service.dart';
import 'core/services/firestore_service.dart';
import 'core/utils/app_router.dart';
import 'core/utils/service_locator.dart';
import 'features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fuujqzoikxyucyycmlpk.supabase.co',
    anonKey: 'sb_publishable_GHKz2sopjedJ-09xYO6NIA_gtWXFKd9',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();

  runApp(const Rewire());
}

class Rewire extends StatelessWidget {
  const Rewire({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        getIt.get<FirebaseAuthService>(),
        getIt.get<FirestoreService>(),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.transparent,
          textTheme: GoogleFonts.nunitoSansTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
      ),
    );
  }
}


/* 

* Todo: click on group id to copy it ✅
* Todo: fix delete cubit on alert dialog & remove delete states from habit cubit ✅
* Todo: separate create group cubit ✅
* Todo: finish group settings view{group image logic & change group data} ✅
* Todo: show checkin status ✅
* Todo: fix create group button while creating new group ✅
  Todo: change input type for login password
  Todo: change validation on login view
  Todo: fix user can pop while loading
  Todo: update group name on details view after update it in group settings
  Todo: fix group image bug if there is one

* listen to members so when new member added to update the list
* refactor add member bottom sheet & custom accordion
  Todo: success toastification shown twice when new account created : FIX IT

*/