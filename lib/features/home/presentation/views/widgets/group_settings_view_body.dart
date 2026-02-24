import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/add_people_container.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_avatar.dart';
import 'package:rewire/features/home/presentation/views/widgets/group_data_fields.dart';

class GroupSettingsViewBody extends StatelessWidget {
  const GroupSettingsViewBody({super.key, required this.viewModel});

  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          const SizedBox(height: 8),

          const SizedBox(height: 16),

          CustomAvatar(viewModel: viewModel),

          const SizedBox(height: 24),

          const GroupDataFields(),

          Align(
            alignment: .centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: CustomButton(
                title: 'Save',
                width: 90,
                height: 40,
                onPressed: () {},
              ),
            ),
          ),
          const AddPeopleContainer(),

          CustomButton(
            title: 'Delete group',
            color: AppColors.red,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
