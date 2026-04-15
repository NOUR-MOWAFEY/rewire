import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/delete_group_button.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/group_data_form.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/group_settings_view_app_bar.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_accordion.dart';
import 'package:rewire/features/home/presentation/views/widgets/group_image_builder.dart';

class GroupSettingsViewBody extends StatelessWidget {
  const GroupSettingsViewBody({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          ListView(
            children: [
              const GroupSettingsViewAppBar(),

              const SizedBox(height: 24),

              GroupImageBuilder(groupModel: groupModel),

              const SizedBox(height: 24),

              GroupDataForm(groupModel: groupModel),

              CustomAccordion(groupModel: groupModel),

              const SizedBox(height: 36),
            ],
          ),

          Align(
            alignment: .bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: DeleteGroupButton(groupModel: groupModel),
            ),
          ),
        ],
      ),
    );
  }
}
