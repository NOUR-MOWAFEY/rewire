import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/validator.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:rewire/features/home/presentation/views/widgets/add_people_container.dart';

class CreateGroupModalBottomSheetBody extends StatelessWidget {
  const CreateGroupModalBottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 550,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
          gradient:  LinearGradient(
            colors: AppColors.gradientColors,
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            const CustomTextFormField(
              title: 'Group name',
              icon: FontAwesomeIcons.peopleGroup,
              inputType: InputType.name,
              isLastOne: true,
            ),
            const AddPeopleContainer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(title: 'Create Group', onPressed: () {}),
                ),
                const SizedBox(width: 8),
                CustomButton(
                  onPressed: () {},
                  width: 70,
                  child: const Icon(
                    FontAwesomeIcons.plus,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
