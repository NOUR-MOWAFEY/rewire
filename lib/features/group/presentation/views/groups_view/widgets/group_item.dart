import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/constants.dart';
import 'package:rewire/features/group/data/models/group_details_view_model.dart';
import 'package:rewire/features/group/presentation/views/groups_view/widgets/group_item_date.dart';
import 'package:rewire/features/group/presentation/views/groups_view/widgets/group_item_name.dart';
import 'package:rewire/features/group/presentation/views/groups_view/widgets/group_item_trailing_item.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../data/models/group_model.dart';
import 'group_item_image.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({
    super.key,
    required this.groupModel,
    required this.isLastItem,
    required this.isFirstItem,
  });
  final GroupModel groupModel;
  final bool isLastItem;
  final bool isFirstItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .center,
      children: [
        isFirstItem ? const SizedBox(height: 30) : const SizedBox(),
        InkWell(
          onTap: () => _groupItemOnTap(context),
          borderRadius: BorderRadius.circular(28),

          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6),

            decoration: BoxDecoration(
              color: AppColors.transparentPrimary,
              borderRadius: BorderRadius.circular(28),
            ),

            child: ListTile(
              // group image
              leading: Hero(
                tag: '${AppRouter.groupsView}_image_${groupModel.id}',
                child: GroupItemImage(groupModel: groupModel),
              ),

              // group name with hero animation
              title: GroupItemName(groupModel: groupModel),

              // created at
              subtitle: GroupItemDate(groupModel: groupModel),

              // arrow icon
              trailing: const GroupItemTrailingIcon(),
            ),
          ),
        ),

        isLastItem
            ? const SizedBox(height: AppConstants.spaceForBottomNavBar)
            : const SizedBox(),
      ],
    );
  }

  Future<Object?> _groupItemOnTap(BuildContext context) {
    return context.push(
      AppRouter.groupDetailsView,
      extra: GroupDetailsViewModel(
        groupModel: groupModel,
        fromViewPath: AppRouter.groupsView,
      ),
    );
  }
}
