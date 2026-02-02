import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_animations.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';

abstract class AppRouter {
  static const registerView = '/RegisterView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginView()),
      GoRoute(
        path: registerView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: RegisterView(),
            transitionsBuilder: AppAnimation.rightToLeftFade,
          );
        },
      ),
      // GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
