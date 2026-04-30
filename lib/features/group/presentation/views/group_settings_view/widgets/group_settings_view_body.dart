import 'package:flutter/material.dart';
import '../../../../data/models/group_model.dart';
import 'group_data_form.dart';
import 'group_settings_view_app_bar.dart';
import 'custom_accordion.dart';
import 'group_image_builder.dart';

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
        ],
      ),
    );
  }
}
