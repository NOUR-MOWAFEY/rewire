import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_back_button.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/views/group_details_view/widgets/custom_menu_button.dart';

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
              groupModel.title,
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
