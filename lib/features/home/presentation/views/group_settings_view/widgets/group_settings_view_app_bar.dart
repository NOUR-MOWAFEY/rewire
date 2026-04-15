import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_back_button.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/group_join_code_widget.dart';

class GroupSettingsViewAppBar extends StatelessWidget {
  const GroupSettingsViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CustomBackButton(),

        SizedBox(width: 8),

        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('ID:', style: AppStyles.textStyle20),

              SizedBox(width: 4),

              GroupJoinCodeWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
