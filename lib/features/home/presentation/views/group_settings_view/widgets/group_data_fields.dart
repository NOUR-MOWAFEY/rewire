import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/validator.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_underline_text_field.dart';

class GroupDataFields extends StatelessWidget {
  const GroupDataFields({
    super.key,
    required this.groupNameController,
    required this.groupPasswordController,
  });

  final TextEditingController groupNameController;
  final TextEditingController groupPasswordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // group name text field
          const Text('Group name: ', style: AppStyles.textStyle14),
          CustomUnderlineTextField(
            controller: groupNameController,
            hintText: 'Group name',
            textInputType: .name,
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: 16),

          // group password text field
          const Text('Password: ', style: AppStyles.textStyle14),
          CustomUnderlineTextField(
            controller: groupPasswordController,
            inputType: InputType.password,
            hintText: 'Password',
            textInputType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}
