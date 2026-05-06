import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/group/data/models/group_model.dart';

class GroupItemName extends StatelessWidget {
  const GroupItemName({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${AppRouter.groupsView}_name_${groupModel.id}',
      placeholderBuilder: (context, heroSize, child) => Material(
        color: Colors.transparent,
        child: Text(
          '',
          style: AppStyles.textStyle20.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Text(
          groupModel.name,
          style: AppStyles.textStyle20.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
