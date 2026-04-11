import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/app_animations.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/create_group_cubit/create_group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/invitations_cubit/invitations_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/join_group_cubit/join_group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/create_group_view.dart';
import 'package:rewire/features/home/presentation/views/group_info_view/group_info_view.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/group_settings_view.dart';
import 'package:rewire/features/home/presentation/views/main_navigation_view.dart';

import '../../features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/home/presentation/views/group_details_view/group_details_view.dart';
import '../../features/home/presentation/views/home_view/home_view.dart';
import '../services/firebase_auth_service.dart';
import 'service_locator.dart';

abstract class AppRouter {
  static const loginView = '/LoginView';
  static const registerView = '/RegisterView';
  static const homeView = '/HomeView';
  static const groupDetailsView = '/GroupDetailsView';
  static const createGroupView = '/CreateGroupView';
  static const groupSettingsView = '/GroupSettingsView';
  static const mainNavigationView = '/MainNavigationView';
  static const groupInfoView = '/GroupInfoView';
  static const invitationsView = '/InvitationsView';

  static final _firebaseAuthService = getIt.get<FirebaseAuthService>();
  static final _fireStoreService = getIt.get<FirestoreService>();

  static final router = GoRouter(
    initialLocation: loginView,

    redirect: (context, state) {
      final isLoggedIn = _firebaseAuthService.isUserAuthenticated();
      final goingToLoginOrRegister =
          state.uri.toString() == loginView ||
          state.uri.toString() == registerView;

      // Logged in → skip login/register → go home
      if (isLoggedIn && goingToLoginOrRegister) return mainNavigationView;

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
          return HomeView(user: user);
        },
      ),

      GoRoute(
        path: groupDetailsView,

        builder: (context, state) =>
            GroupDetailsView(groupModel: state.extra as GroupModel),
      ),

      GoRoute(
        path: createGroupView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CreateGroupCubit(
                _fireStoreService,
                _firebaseAuthService.getCurrentUser(),
              ),
            ),
            BlocProvider(create: (context) => MembersCubit()),
          ],
          child: const CreateGroupView(),
        ),
      ),

      GoRoute(
        path: groupSettingsView,

        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  JoinGroupCubit(_fireStoreService, _firebaseAuthService),
            ),
            BlocProvider(create: (context) => MembersCubit()),
          ],
          child: GroupSettingsView(groupModel: state.extra as GroupModel),
        ),
      ),

      GoRoute(
        path: mainNavigationView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 300),
            child: BlocProvider(
              create: (context) => InvitationsCubit(
                getIt.get<FirestoreService>(),
                _firebaseAuthService.getCurrentUser()!.uid,
              ),
              child: const MainNavigationView(),
            ),
            transitionsBuilder: AppAnimation.fade,
          );
        },
      ),

      GoRoute(
        path: groupInfoView,

        builder: (context, state) =>
            GroupInfoView(groupModel: state.extra as GroupModel),
      ),
    ],
  );
}
