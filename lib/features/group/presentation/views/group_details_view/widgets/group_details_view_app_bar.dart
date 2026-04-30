import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_back_button.dart';
import '../../../../data/models/group_model.dart';
import 'custom_menu_button.dart';

class GroupDetailsViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GroupDetailsViewAppBar({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,

      title: Row(
        children: [
          const CustomBackButton(),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              groupModel.name,
              style: AppStyles.textStyle24.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      actions: [
        CustomMenuButton(groupModel: groupModel),
        const SizedBox(width: 6),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
