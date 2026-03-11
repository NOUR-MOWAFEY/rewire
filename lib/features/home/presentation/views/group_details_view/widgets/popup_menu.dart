import 'package:flutter/material.dart';
import 'package:rewire/features/home/presentation/views/group_details_view/widgets/popup_menu_body.dart';
import 'package:rewire/features/home/presentation/views/group_details_view/widgets/popup_menu_checkin_icons.dart';
import 'package:rewire/features/home/presentation/views/group_details_view/widgets/popup_menu_header.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key, this.isFirstOne = false});
  final bool isFirstOne;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const PopUpMenuHeader(),

          isFirstOne ? const Spacer() : const SizedBox(height: 12),

          PopUpMenuBody(isFirtOne: isFirstOne),

          const SizedBox(height: 4),

          !isFirstOne
              ? const SizedBox()
              : const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: PopupMenuCheckInIcons(),
                ),
        ],
      ),
    );
  }
}
