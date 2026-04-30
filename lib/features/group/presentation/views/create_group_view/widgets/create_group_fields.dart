import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/utils/validator.dart';
import '../../../../../auth/presentation/views/widgets/custom_text_form_field.dart';
import '../../../view_model/create_group_cubit/create_group_cubit.dart';

class CreateGroupFields extends StatelessWidget {
  const CreateGroupFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateGroupCubit>();

    return Column(
      children: [
        CustomTextFormField(
          title: 'Group name',
          icon: FontAwesomeIcons.userGroup,
          inputType: InputType.name,
          isLastOne: false,
          controller: cubit.groupNameController,
          border: false,
        ),
        const SizedBox(height: 12),

        CustomTextFormField(
          title: 'Group password',
          icon: FontAwesomeIcons.lock,
          inputType: InputType.password,
          isLastOne: false,
          controller: cubit.groupPasswordController,
          border: false,
          isPassword: true,
        ),
      ],
    );
  }
}
