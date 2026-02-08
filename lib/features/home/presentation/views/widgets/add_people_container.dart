import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import 'add_people_container_item.dart';

class AddPeopleContainer extends StatelessWidget {
  const AddPeopleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      height: 350,
      decoration: BoxDecoration(
        color: AppColors.transparentPrimary,
        border: Border.all(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 12, left: 16, right: 16),
            margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Group Members',
                  style: AppStyles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(indent: 32, endIndent: 32, color: AppColors.primary),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListView(
                children: const [
                  AddPeopleContainerItem(),
                  SizedBox(height: 8),
                  AddPeopleContainerItem(),
                  SizedBox(height: 8),
                  AddPeopleContainerItem(),
                  SizedBox(height: 8),
                  AddPeopleContainerItem(),
                  SizedBox(height: 8),
                  AddPeopleContainerItem(),
                  SizedBox(height: 8),
                  AddPeopleContainerItem(),
                  SizedBox(height: 8),
                  AddPeopleContainerItem(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
