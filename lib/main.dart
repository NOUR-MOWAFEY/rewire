import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/services/firebase_service.dart';
import 'core/services/firestore_service.dart';
import 'core/utils/app_router.dart';
import 'features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ReWire());
}

class ReWire extends StatelessWidget {
  const ReWire({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(FirebaseService(), FirestoreService()),
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
