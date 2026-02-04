import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/service_locator.dart';
import '../services/firebase_service.dart';
import '../../features/home/presentation/views/home_view.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';

abstract class AppRouter {
  static const loginView = '/LoginView';
  static const registerView = '/RegisterView';
  static const homeView = '/HomeView';
  static final firebaseService = getIt.get<FirebaseService>();

  static final router = GoRouter(
    initialLocation: loginView,

    redirect: (context, state) {
      final isLoggedIn = firebaseService.isUserAuthenticated();
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
      GoRoute(path: homeView, builder: (context, state) => const HomeView()),
    ],
  );
}
