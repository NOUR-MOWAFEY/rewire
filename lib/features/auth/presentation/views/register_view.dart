import 'package:flutter/material.dart';

import '../../../../core/widgets/view_background_container.dart';
import 'widgets/register_view_app_bar.dart';
import 'widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: const RegisterViewAppBar(),
      viewBody: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const RegisterViewBody(),
      ),
    );
  }
}
