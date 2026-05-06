import 'package:flutter/material.dart';

EdgeInsets viewPadding(BuildContext context) {
  return EdgeInsets.symmetric(horizontal: 30, vertical: 0);
}

class AppConstants {
  static const double spaceForBottomNavBar = 120;
}

class StorageKeys {
  static const storedDate = 'stored_date';
  static const isFirstLaunch = 'is_first_launch';
  static const userProfileImage = 'user_profile_image';
}
