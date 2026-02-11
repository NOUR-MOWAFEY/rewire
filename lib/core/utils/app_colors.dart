import 'package:flutter/material.dart';

class AppColors {
  // gradient background colors
  static const background = Color.fromARGB(171, 32, 49, 29);
  static const background2 = Color.fromARGB(197, 51, 88, 74);
  static const background3 = Color.fromARGB(218, 84, 153, 136);

  // main colors
  static const primary = Color(0xFF5E936C);
  static const transparentPrimary = Color.fromARGB(132, 94, 147, 108);
  static const secondary = Color(0xFF3E5F44);
  static const secondary2 = Color(0xFF97B067);
  static const transparentDarkBackground = Color.fromARGB(136, 32, 49, 29);

  // other colors
  static const black = Colors.black;
  static const white = Colors.white;
  static const red = Colors.red;
  static const green = Colors.green;

  // gradient colors for background
  static const List<Color> gradientColors = [
    AppColors.background3,
    AppColors.background2,
    AppColors.background,
  ];
}


/*  OLD COLORS

  static const background = Color.fromARGB(193, 23, 36, 21);
  static const primary = Color(0xFF5E936C);
  static const transparentPrimary = Color.fromARGB(132, 94, 147, 108);

  static const secondary = Color(0xFF3E5F44);
  static const white = Colors.white;
}

*/