import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/group_model.dart';

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
          Text(groupModel.name, style: AppStyles.textStyle24),

          const SizedBox(height: 8),

          QrImageView(
            data: groupModel.id,
            version: QrVersions.auto,
            size: MediaQuery.of(context).size.width - 50,
            backgroundColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
