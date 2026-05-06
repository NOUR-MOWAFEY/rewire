import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/group/data/models/group_model.dart';

class GroupItemName extends StatelessWidget {
  const GroupItemName({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      groupModel.name,
      style: AppStyles.textStyle20.copyWith(overflow: TextOverflow.ellipsis),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
