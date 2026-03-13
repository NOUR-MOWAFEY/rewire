import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_underline_text_field.dart';

class PopUpMenuBody extends StatelessWidget {
  const PopUpMenuBody({
    super.key,
    required this.isFirtOne,
    required this.isTodayItem,
  });
  final bool isFirtOne;
  final bool isTodayItem;

  @override
  Widget build(BuildContext context) {
    return !isFirtOne || !isTodayItem
        ? Text(
            'Message: Hello from test version of the app',
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
