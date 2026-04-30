import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_back_button.dart';

class RegisterViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const RegisterViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const CustomBackButton(),
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
