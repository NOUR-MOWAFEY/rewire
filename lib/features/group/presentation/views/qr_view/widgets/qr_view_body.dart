import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../data/models/group_model.dart';

class QrViewBody extends StatelessWidget {
  const QrViewBody({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(groupModel.name, style: AppStyles.textStyle24),
          ),

          const SizedBox(height: 8),

          Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(28),
              ),

              padding: const EdgeInsets.all(12),

              child: QrImageView(
                data: groupModel.id,
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width - 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
