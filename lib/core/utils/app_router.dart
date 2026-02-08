import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../services/firestore_service.dart';
import 'service_locator.dart';
import '../../features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import '../../features/home/presentation/view_model/habit_cubit/habit_cubit.dart';
import '../../features/home/presentation/views/group_details_view.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../services/firebase_service.dart';

abstract class AppRouter {
  static const loginView = '/LoginView';
  static const registerView = '/RegisterView';
  static const homeView = '/HomeView';
  static const groupDetailsView = '/GroupDetailsView';
  static final _firebaseAuthService = getIt.get<FirebaseAuthService>();

  static final router = GoRouter(
    initialLocation: loginView,

    redirect: (context, state) {
      final isLoggedIn = _firebaseAuthService.isUserAuthenticated();
      final goingToLoginOrRegister =
          state.uri.toString() == loginView ||
          state.uri.toString() == registerView;

      // Logged in → skip login/register → go home
      if (isLoggedIn && goingToLoginOrRegister) return homeView;

      // Not logged in → trying to access home → go login
      if (!isLoggedIn && state.uri.toString() == homeView) return loginView;

      return null; // no redirect
    },

    routes: [
      GoRoute(path: loginView, builder: (context, state) => const LoginView()),

      GoRoute(
        path: registerView,
        builder: (context, state) => const RegisterView(),
      ),

      GoRoute(
        path: homeView,
        builder: (context, state) {
          var user = BlocProvider.of<AuthCubit>(context).getUser();
          return BlocProvider(
            create: (context) =>
                HabitCubit(getIt.get<FirestoreService>(), user),
            child: HomeView(user: user),
          );
        },
      ),
      GoRoute(
        path: groupDetailsView,
        builder: (context, state) => const GroupDetailsView(),
      ),
    ],
  );
}
