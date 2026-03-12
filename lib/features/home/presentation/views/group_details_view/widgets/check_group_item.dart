import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/check_icon_button.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class CheckGroupItem extends StatelessWidget {
  const CheckGroupItem({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 4),
          child: Text(date, style: AppStyles.textStyle14),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          height: 85,
          width: 80,
          decoration: BoxDecoration(
            color: AppColors.transparentPrimary,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: .horizontal,

                itemBuilder: (context, index) {
                  return CheckIconButton(
                    index: index,
                    checkInStatus: CheckInStatus.pending,
                  );
                },

                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: const VerticalDivider(
                    color: AppColors.primary,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),

                itemCount: members.length,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const List<String> members = ['1', '2', '3', '4', '5'];

