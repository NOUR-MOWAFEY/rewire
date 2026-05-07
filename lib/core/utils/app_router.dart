import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/services/firestore/firestore_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/group/data/models/group_details_view_model.dart';
import 'package:rewire/features/group/data/models/group_model.dart';
import 'package:rewire/features/group/presentation/view_model/days_cubit/days_cubit.dart';
import 'package:rewire/features/group/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/group/presentation/views/qr_view/qr_view.dart';

import '../../../main_navigation_view.dart';
import '../../features/auth/presentation/view_model/user_cubit/user_cubit.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/group/data/models/group_info_view_data.dart';
import '../../features/group/presentation/view_model/delete_group_cubit/delete_group_cubit.dart';
import '../../features/group/presentation/view_model/group_cubit/group_cubit.dart';
import '../../features/group/presentation/views/create_group_view/create_group_view.dart';
import '../../features/group/presentation/views/group_details_view/group_details_view.dart';
import '../../features/group/presentation/views/group_info_view/group_info_view.dart';
import '../../features/group/presentation/views/group_settings_view/group_settings_view.dart';
import '../../features/group/presentation/views/groups_view/groups_view.dart';
import '../../features/invitations/presentation/view_model/invitations_cubit/invitations_cubit.dart';
import '../services/firebase_auth_service.dart';
import '../services/supabase_storage_service.dart';
import 'app_animations.dart';
import 'service_locator.dart';

abstract class AppRouter {
  static const loginView = '/LoginView';
  static const registerView = '/RegisterView';
  static const groupsView = '/GroupsView';
  static const groupDetailsView = '/GroupDetailsView';
  static const createGroupView = '/CreateGroupView';
  static const groupSettingsView = '/GroupSettingsView';
  static const mainNavigationView = '/MainNavigationView';
  static const groupInfoView = '/GroupInfoView';
  static const invitationsView = '/InvitationsView';
  static const leaderboardView = '/LeaderboardView';
  static const qrView = '/QrView';

  static final _firebaseAuthService = getIt.get<FirebaseAuthService>();
  static final _fireStoreService = getIt.get<FirestoreService>();
  static final _supabaseStorageService = getIt.get<SupabaseStorageService>();

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
      if (!isLoggedIn && state.uri.toString() == groupsView) return loginView;

      return null; // no redirect
    },

    routes: [
      GoRoute(
        path: loginView,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const LoginView(),
          transitionsBuilder: AppAnimation.fade,
        ),
      ),

      GoRoute(
        path: registerView,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const RegisterView(),
          transitionsBuilder: AppAnimation.rightToLeft,
          barrierColor: AppColors.transitionColor,
        ),
      ),

      ShellRoute(
        builder: (context, state, child) {
          final userId = _firebaseAuthService.getCurrentUser()?.uid;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  final userCubit = UserCubit(_fireStoreService);
                  if (userId != null) userCubit.listenToUser(userId);
                  return userCubit;
                },
              ),
              BlocProvider(
                create: (context) {
                  final groupCubit = GroupCubit(_fireStoreService);
                  if (userId != null) groupCubit.listenToGroups(userId);
                  return groupCubit;
                },
              ),
            ],
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: groupsView,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const GroupsView(),
              transitionsBuilder: AppAnimation.fade,
            ),
          ),

          GoRoute(
            path: groupDetailsView,

            pageBuilder: (context, state) {
              final groupDetailsViewModel =
                  state.extra as GroupDetailsViewModel;

              return CustomTransitionPage(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => DaysCubit(
                        _fireStoreService,
                        groupDetailsViewModel.groupModel.id,
                        groupCubit: context.read<GroupCubit>(),
                      )..listenToDays(),
                    ),
                    BlocProvider(
                      lazy: false,
                      create: (context) => MembersCubit()
                        ..listenToAllMembers(
                          groupDetailsViewModel.groupModel.id,
                        ),
                    ),
                  ],
                  child: Material(
                    child: GroupDetailsView(
                      groupDetailsViewModel: groupDetailsViewModel,
                    ),
                  ),
                ),
                // transitionDuration: const Duration(milliseconds: 1000),
                // reverseTransitionDuration: const Duration(milliseconds: 1000),
                transitionsBuilder: AppAnimation.rightToLeft,
                barrierColor: AppColors.transitionColor,
              );
            },
          ),

          GoRoute(
            path: createGroupView,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: const CreateGroupView(),
              transitionsBuilder: AppAnimation.rightToLeft,
              barrierColor: AppColors.transitionColor,
            ),
          ),

          GoRoute(
            path: groupSettingsView,

            pageBuilder: (context, state) => CustomTransitionPage(
              child: BlocProvider(
                create: (context) => DeleteGroupCubit(
                  _fireStoreService,
                  _supabaseStorageService,
                ),
                child: GroupSettingsView(
                  groupDataModel: state.extra as GroupDataModel,
                ),
              ),
              transitionsBuilder: AppAnimation.rightToLeft,
              barrierColor: AppColors.transitionColor,
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

            pageBuilder: (context, state) => CustomTransitionPage(
              child: GroupInfoView(dataModel: state.extra as GroupDataModel),
              transitionsBuilder: AppAnimation.rightToLeft,
              barrierColor: AppColors.transitionColor,
            ),
          ),

          GoRoute(
            path: qrView,
            pageBuilder: (context, state) => CustomTransitionPage(
              child: QrView(groupModel: state.extra as GroupModel),
              transitionsBuilder: AppAnimation.rightToLeft,
              barrierColor: AppColors.transitionColor,
            ),
          ),
        ],
      ),
    ],
  );
}
