import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/services/firebase_service.dart';
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
  Todo: finish group settings view{group image logic & change group data} // ! To Be continued
  Todo: change input type for login password
  Todo: change validation on login view

*/