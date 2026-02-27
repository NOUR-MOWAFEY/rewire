import 'package:flutter/material.dart';
import 'package:rewire/core/widgets/custom_button.dart';

class CustomSaveButton extends StatelessWidget {
  const CustomSaveButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: CustomButton(
          title: 'Save',
          width: 90,
          height: 40,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
