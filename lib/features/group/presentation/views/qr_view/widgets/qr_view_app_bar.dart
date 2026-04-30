import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_back_button.dart';

class QrViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QrViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,

      title: Row(
        children: [
          const CustomBackButton(),

          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'QR Code',
              style: AppStyles.textStyle24.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
