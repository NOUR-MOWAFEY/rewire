import 'package:flutter/material.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/views/qr_view/widgets/qr_view_app_bar.dart';
import 'package:rewire/features/home/presentation/views/qr_view/widgets/qr_view_body.dart';

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
