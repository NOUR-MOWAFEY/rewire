import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewire/features/home/presentation/view_model/habit_cubit/habit_cubit.dart';

import 'core/services/firebase_service.dart';
import 'core/services/firestore_service.dart';
import 'core/utils/app_router.dart';
import 'core/utils/service_locator.dart';
import 'features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();

  runApp(const Rewire());
}

class Rewire extends StatelessWidget {
  const Rewire({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            getIt.get<FirebaseAuthService>(),
            getIt.get<FirestoreService>(),
          ),
        ),
        BlocProvider(
          create: (context) => HabitCubit(
            getIt.get<FirestoreService>(),
            getIt.get<FirebaseAuthService>().getCurrentUser(),
          ),
        ),
      ],
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
