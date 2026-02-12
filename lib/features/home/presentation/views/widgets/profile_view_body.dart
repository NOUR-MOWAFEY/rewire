import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/widgets/custom_button.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  File? _imageFile;

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .center,
      child: Column(
        children: [
          const SizedBox(height: 48),
          CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.transparentPrimary,
            backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
            child: _imageFile == null ? const ProfileDefaultAvatar() : null,
          ),
          const SizedBox(height: 12),
          CustomButton(
            title: 'Upload image',
            width: 180,
            onPressed: () => pickImage(),
          ),
        ],
      ),
    );
  }
}

class ProfileDefaultAvatar extends StatelessWidget {
  const ProfileDefaultAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesomeIcons.user,
      size: 48,
      color: const Color.fromARGB(218, 224, 224, 224),
    );
  }
}
