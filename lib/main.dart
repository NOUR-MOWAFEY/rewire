import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_router.dart';

void main() {
  runApp(const ReWire());
}

class ReWire extends StatelessWidget {
  const ReWire({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.nunitoSansTextTheme(ThemeData.dark().textTheme),
      ),
    );
  }
}
