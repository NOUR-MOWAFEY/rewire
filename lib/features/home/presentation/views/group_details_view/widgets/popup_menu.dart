import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/presentation/views/group_details_view/widgets/popup_menu_body.dart';
import 'package:rewire/features/home/presentation/views/group_details_view/widgets/popup_menu_checkin_icons.dart';
import 'package:rewire/features/home/presentation/views/group_details_view/widgets/popup_menu_header.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    super.key,
    required this.checkIn,
    this.isCurrentUser = false,
    this.isTodayItem = false,
  });
  final CheckInModel checkIn;
  final bool isCurrentUser;
  final bool isTodayItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PopUpMenuHeader(checkIn: checkIn),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),

              child: PopUpMenuBody(
                checkIn: checkIn,
                isCurrentUser: isCurrentUser,
                isTodayItem: isTodayItem,
              ),
            ),
          ),
          !isCurrentUser || !isTodayItem
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 6),
                  child: PopupMenuCheckInIcons(),
                ),
        ],
      ),
    );
  }
}
