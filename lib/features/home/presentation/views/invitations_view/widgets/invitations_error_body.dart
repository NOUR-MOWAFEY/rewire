import 'package:flutter/material.dart';

class InvitationsErrorBody extends StatelessWidget {
  const InvitationsErrorBody({super.key, required this.errMessage});
  final String errMessage;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(errMessage, style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
