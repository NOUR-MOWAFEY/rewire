import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'core/services/firebase_auth_service.dart';
import 'core/services/firestore_service.dart';
import 'core/utils/app_router.dart';
import 'core/utils/service_locator.dart';
import 'features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'features/home/presentation/view_model/group_cubit/group_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            getIt.get<FirebaseAuthService>(),
            getIt.get<FirestoreService>(),
          ),
        ),
        BlocProvider(
          create: (context) {
            final groupCubit = GroupCubit(getIt.get<FirestoreService>());
            final user = getIt.get<FirebaseAuthService>().getCurrentUser();
            if (user != null) {
              groupCubit.listenToGroups(user.uid);
            }
            return groupCubit;
          },
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.read<GroupCubit>().listenToGroups(state.user!.uid);
          } else if (state is AuthUnAuthenticated) {
            context.read<GroupCubit>().clearCache();
          }
        },
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
      ),
    );
  }
}
