import 'package:flutter/material.dart';

import '../../../../core/widgets/view_background_container.dart';
import 'widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewBackGroundContainer(viewBody: LoginViewBody());
  }
}
