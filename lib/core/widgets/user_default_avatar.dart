import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDefaultAvatar extends StatelessWidget {
  const UserDefaultAvatar({super.key, this.size = 48});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesomeIcons.user,
      size: size,
      color: const Color.fromARGB(218, 224, 224, 224),
    );
  }
}
