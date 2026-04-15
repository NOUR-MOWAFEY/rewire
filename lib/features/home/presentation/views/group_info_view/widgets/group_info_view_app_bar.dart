import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_back_button.dart';
import 'package:rewire/features/home/data/models/group_model.dart';

class GroupInfoViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GroupInfoViewAppBar({super.key, required this.groupModel});
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
              'Info',
              style: AppStyles.textStyle24.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          Text(
            groupModel.createdAt == null
                ? 'Created at: '
                : DateFormat(
                    'dd/MM/yyyy',
                  ).format(groupModel.createdAt!.toDate()),
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
