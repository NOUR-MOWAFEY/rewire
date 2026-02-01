import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_styles.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.archivoBlack(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(subtitle, style: AppStyles.textStyle18),
      ],
    );
  }
}
