import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/group_item_image.dart';

import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../data/models/group_model.dart';

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
          onTap: () =>
              context.push(AppRouter.groupDetailsView, extra: groupModel),

          borderRadius: BorderRadius.circular(28),

          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            width: double.infinity,

            decoration: BoxDecoration(
              color: AppColors.transparentPrimary,
              borderRadius: BorderRadius.circular(28),
            ),

            child: ListTile(
              // group image
              leading: GroupItemImage(groupModel: groupModel),

              // group name
              title: Text(
                groupModel.name,
                style: AppStyles.textStyle20.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              //  created at
              subtitle: Text(
                groupModel.createdAt == null
                    ? 'Created at: '
                    : 'Created at: ${DateFormat('dd/MM/yyyy').format(groupModel.createdAt!.toDate())}',
                style: AppStyles.textStyle12.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // arrow icon
              trailing: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  FontAwesomeIcons.angleRight,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),

        isLastItem
            ? SizedBox(height: MediaQuery.of(context).size.height * 0.1)
            : const SizedBox(),
      ],
    );
  }
}
