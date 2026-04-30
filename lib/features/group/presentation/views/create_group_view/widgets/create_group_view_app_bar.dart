import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_back_button.dart';

class CreateGroupViewAppBar extends StatelessWidget {
  const CreateGroupViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomBackButton(),
        const SizedBox(width: 12),
        Text('Create Group', style: AppStyles.textStyle22),
      ],
    );
  }
}
