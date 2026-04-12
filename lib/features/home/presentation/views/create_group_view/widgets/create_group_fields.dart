import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/utils/validator.dart';
import '../../../../../auth/presentation/views/widgets/custom_text_form_field.dart';

class CreateGroupFields extends StatelessWidget {
  const CreateGroupFields({
    super.key,
    required this.groupNameController,
    required this.groupPasswordController,
  });

  final TextEditingController groupNameController;
  final TextEditingController groupPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          title: 'Group name',
          icon: FontAwesomeIcons.userGroup,
          inputType: InputType.name,
          isLastOne: false,
          controller: groupNameController,
          border: false,
        ),
        const SizedBox(height: 12),

        CustomTextFormField(
          title: 'Group password',
          icon: FontAwesomeIcons.lock,
          inputType: InputType.password,
          isLastOne: false,
          controller: groupPasswordController,
          border: false,
          isPassword: true,
        ),
      ],
    );
  }
}
