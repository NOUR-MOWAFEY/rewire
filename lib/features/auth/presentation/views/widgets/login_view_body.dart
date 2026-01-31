import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/auth/presentation/views/widgets/custom_text_form_field.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: ListView(
        children: [
          const SizedBox(height: 60),
          Text(
            'Welcome back',
            style: GoogleFonts.archivoBlack(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Sign in to continue rewiring',
            style: AppStyles.textStyle18,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .22),
          const CustomTextFormField(
            title: 'Email',
            icon: FontAwesomeIcons.envelope,
          ),
          const SizedBox(height: 12),
          const CustomTextFormField(
            title: 'Password',
            isPassword: true,
            icon: FontAwesomeIcons.lock,
          ),
          const SizedBox(height: 20),
          const CustomButton(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account?  ',
                style: AppStyles.textStyle16,
              ),
              Text(
                'Register',
                style: AppStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .1),
        ],
      ),
    );
  }
}
