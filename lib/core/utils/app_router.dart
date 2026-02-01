import 'package:go_router/go_router.dart';
import 'package:rewire/features/auth/presentation/views/login_view.dart';
import 'package:rewire/features/auth/presentation/views/register_view.dart';

abstract class AppRouter {
  static const registerView = '/RegisterView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginView()),
      GoRoute(
        path: registerView,
        builder: (context, state) => const RegisterView(),
      ),
      // GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
