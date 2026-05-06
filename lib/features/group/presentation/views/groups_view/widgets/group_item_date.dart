import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/group/data/models/group_model.dart';

class GroupItemDate extends StatelessWidget {
  const GroupItemDate({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      groupModel.createdAt == null
          ? 'Created at: '
          : 'Created at: ${DateFormat('dd/MM/yyyy').format(groupModel.createdAt!.toDate())}',
      style: AppStyles.textStyle12.copyWith(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
