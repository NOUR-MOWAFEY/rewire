import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/utils/app_colors.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/group_model.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({
    super.key,
    required this.habitModel,
    required this.isLastItem,
    required this.isFirstItem,
  });
  final GroupModel habitModel;
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
              context.push(AppRouter.groupDetailsView, extra: habitModel),

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
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.transparentPrimary,
                child: SvgPicture.asset('assets/images/pic.svg'),
              ),

              // group name
              title: Text(
                habitModel.title,
                style: AppStyles.textStyle20.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              //  created at
              subtitle: Text(
                habitModel.createdAt == null
                    ? 'Created at: '
                    : 'Created at: ${DateFormat.yMd().format(habitModel.createdAt!.toDate())}',
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
