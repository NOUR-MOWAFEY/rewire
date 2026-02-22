import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/widgets/custom_back_button.dart';

class CustomDetailsViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomDetailsViewAppBar({super.key, required this.groupName});

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const CustomBackButton(),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              groupName,
              style: AppStyles.textStyle24.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: IconButton(
            onPressed: () {
              var days = getIt.get<FirestoreService>().getAllDaysStream(
                'NnKOmJzryB6WfxRmIvE5',
              );
              days.length;
            },
            icon: const Icon(
              FontAwesomeIcons.pen,
              color: AppColors.white,
              size: 20,
            ),
            padding: EdgeInsets.all(12),
          ),
        ),
        const SizedBox(width: 6),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
