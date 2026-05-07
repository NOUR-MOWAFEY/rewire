import 'package:flutter/material.dart';
import 'package:rewire/features/group/data/models/group_details_view_model.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../groups_view/widgets/group_item_image.dart';

class GroupMainInfo extends StatelessWidget {
  const GroupMainInfo({
    super.key,
    required this.groupDetailsViewModel,
    required this.name,
  });

  final GroupDetailsViewModel groupDetailsViewModel;
  final String name;

  @override
  Widget build(BuildContext context) {
    final groupModel = groupDetailsViewModel.groupModel;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Expanded(
        child: Row(
          children: [
            Hero(
              tag:
                  '${groupDetailsViewModel.fromViewPath}_image_${groupModel.id}',
              child: GroupItemImage(groupModel: groupModel, size: 40),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Hero(
                tag:
                    '${groupDetailsViewModel.fromViewPath}_name_${groupModel.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    name,
                    style: AppStyles.textStyle20.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
