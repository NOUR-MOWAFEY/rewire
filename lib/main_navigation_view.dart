import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/group/presentation/views/groups_view/groups_view.dart';
import 'package:rewire/features/invitations/presentation/views/invitations_view.dart';
import 'package:rewire/features/leaderboard/presentation/views/leaderboard_view.dart';
import 'package:rewire/features/profile_view/presentation/views/profile_view.dart';

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _tabs,

      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      navBarOverlap: const NavBarOverlap.full(),
      backgroundColor: Colors.transparent,
      keepNavigatorHistory: false,
      resizeToAvoidBottomInset: false,

      navBarBuilder: (navBarConfig) => ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(32),

        child: Style2BottomNavBar(
          navBarConfig: navBarConfig,

          itemPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

          navBarDecoration: NavBarDecoration(
            color: AppColors.bottomNavBar,
            border: Border.all(
              color: AppColors.transparentPrimary.withValues(alpha: 0.5),
            ),
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            padding: const EdgeInsets.symmetric(vertical: 8),
            borderRadius: BorderRadius.circular(32),
          ),

          itemAnimationProperties: const ItemAnimation(
            duration: Duration(milliseconds: 350),
          ),
        ),
      ),
    );
  }

  List<PersistentTabConfig> get _tabs {
    return [
      PersistentTabConfig(
        screen: const GroupsView(),
        item: _customIconConfig(FontAwesomeIcons.userGroup, 'Groups'),
      ),
      PersistentTabConfig(
        screen: const LeaderboardView(),
        item: _customIconConfig(FontAwesomeIcons.rankingStar, 'Ranks'),
      ),
      PersistentTabConfig(
        screen: const InvitationsView(),
        item: _customIconConfig(FontAwesomeIcons.solidBell, 'Invitations'),
      ),
      PersistentTabConfig(
        screen: const ProfileView(),
        item: _customIconConfig(FontAwesomeIcons.solidCircleUser, 'Profile'),
      ),
    ];
  }

  ItemConfig _customIconConfig(IconData icon, String title) {
    return ItemConfig(
      icon: Icon(icon),
      title: title,
      iconSize: 21,
      textStyle: AppStyles.textStyle12,
      inactiveForegroundColor: Colors.white24,
      activeColorSecondary: AppColors.transparentPrimary,
      activeForegroundColor: AppColors.white,
    );
  }
}
