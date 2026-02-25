import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_underline_text_field.dart';

class GroupDataFields extends StatelessWidget {
  const GroupDataFields({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text('Group name: ', style: AppStyles.textStyle14),
          CustomUnderlineTextField(
            hintText: 'Group name',
            textInputType: .name,
            textInputAction: TextInputAction.next,
          ),

          SizedBox(height: 16),

          Text('Password: ', style: AppStyles.textStyle14),
          CustomUnderlineTextField(
            hintText: 'Password',
            textInputType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}
