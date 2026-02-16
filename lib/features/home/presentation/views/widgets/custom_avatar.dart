import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/widgets/custom_loading.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required File? imageFile,
    required String? imageUrl,
  }) : _imageFile = imageFile,
       _imageUrl = imageUrl;

  final File? _imageFile;
  final String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 130,
        width: 130,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.transparentPrimary,
        ),
        child: ClipOval(
          child: _imageFile != null
              ? Image.file(_imageFile, fit: BoxFit.cover)
              : _imageUrl != null
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: _imageUrl,
                  placeholder: (context, url) => const CustomLoading(size: 30),
                  errorWidget: (context, url, error) => const Icon(
                    FontAwesomeIcons.triangleExclamation,
                    size: 34,
                  ),
                )
              : const ProfileDefaultAvatar(),
        ),
      ),
    );
  }
}

class ProfileDefaultAvatar extends StatelessWidget {
  const ProfileDefaultAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      FontAwesomeIcons.user,
      size: 48,
      color: Color.fromARGB(218, 224, 224, 224),
    );
  }
}
