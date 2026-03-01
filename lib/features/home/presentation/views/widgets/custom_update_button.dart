import 'package:flutter/material.dart';
import 'package:rewire/core/widgets/custom_button.dart';

class CustomUpdateButton extends StatelessWidget {
  const CustomUpdateButton({
    super.key,
    this.onPressed,
    this.title = 'Update',
    this.isEnabled = true,
  });
  final void Function()? onPressed;
  final String? title;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: AbsorbPointer(
          absorbing: !isEnabled!,
          child: CustomButton(
            title: title,
            width: 110,
            height: 40,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
