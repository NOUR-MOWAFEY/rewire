import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/home_view.dart';
import 'package:rewire/features/home/presentation/views/profile_view.dart';
import 'package:rewire/features/home/presentation/views/settings_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Widget> _screens() => const [
    HomeView(),
    SettingsView(),
    SettingsView(),
    ProfileView(),
  ];

  List<PersistentBottomNavBarItem> _items() => [
    _persistentBottomNavBarItem(FontAwesomeIcons.houseChimney, 'Home'),
    _persistentBottomNavBarItem(FontAwesomeIcons.solidBell, 'Notifications'),
    _persistentBottomNavBarItem(FontAwesomeIcons.gear, 'Settings'),
    _persistentBottomNavBarItem(FontAwesomeIcons.solidCircleUser, 'Profile'),
  ];

  PersistentBottomNavBarItem _persistentBottomNavBarItem(
    IconData icon,
    String title,
  ) {
    return PersistentBottomNavBarItem(
      icon: Icon(icon, size: 22),
      title: title,
      textStyle: AppStyles.textStyle12,
      inactiveColorPrimary: Colors.white60,
      activeColorPrimary: AppColors.primary,
      activeColorSecondary: AppColors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens(),
      items: _items(),
      navBarStyle: NavBarStyle.style7,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardAppears: true,
      backgroundColor: AppColors.transparentPrimary,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: AppColors.primary, width: 2),
      ),

      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: FloatingActionButton(
      //     backgroundColor: AppColors.transparentPrimary,
      //     shape: const CircleBorder(),
      //     onPressed: () {
      //       showModalBottomSheet(
      //         isScrollControlled: true,
      //         context: context,
      //         builder: (context) => const CreateGroupModalBottomSheetBody(),
      //       );
      //     },
      //     child: const Icon(FontAwesomeIcons.plus),
      //   ),
      // ),
    );
  }
}
