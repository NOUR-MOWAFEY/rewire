import 'package:flutter/material.dart';

import '../../../../../core/widgets/view_background_container.dart';
import '../../../data/models/group_model.dart';
import 'widgets/qr_view_app_bar.dart';
import 'widgets/qr_view_body.dart';

class QrView extends StatelessWidget {
  const QrView({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: const QrViewAppBar(),
      viewBody: QrViewBody(groupModel: groupModel),
    );
  }
}
