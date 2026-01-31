import 'package:go_router/go_router.dart';
import 'package:rewire/features/auth/presentation/views/login_view.dart';

abstract class AppRouter {
  static const loginView = '/LoginView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginView()),
      // GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
