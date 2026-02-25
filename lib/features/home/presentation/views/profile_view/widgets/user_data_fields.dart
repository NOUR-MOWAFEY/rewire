import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_underline_text_field.dart';

class UserDataFields extends StatelessWidget {
  const UserDataFields({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        Text('Full name: ', style: AppStyles.textStyle14),
        CustomUnderlineTextField(hintText: 'Nour Mowafey'),
        SizedBox(height: 24),
        Text('Email address: ', style: AppStyles.textStyle14),
        CustomUnderlineTextField(
          hintText: 'nourmowafey82@gmail.com',
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
