import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_underline_text_field.dart';

class PopUpMenuBody extends StatelessWidget {
  const PopUpMenuBody({
    super.key,
    required this.checkIn,
    required this.isCurrentUser,
    required this.isTodayItem,
  });
  final CheckInModel checkIn;
  final bool isCurrentUser;
  final bool isTodayItem;

  @override
  Widget build(BuildContext context) {
    return !isCurrentUser || !isTodayItem
        ? Text(
            'Message: ${checkIn.messagePublic ?? "No message"}',
            style: AppStyles.textStyle16,
          )
        : CustomUnderlineTextField(
            hintText: 'Message',
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send_rounded),
            ),
            maxLines: 2,
          );
  }
}
