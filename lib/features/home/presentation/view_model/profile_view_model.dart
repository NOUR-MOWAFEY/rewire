import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';

enum ImageType { user, group }

class ProfileViewModel extends ChangeNotifier {
  final SupabaseStorageService storageService;
  final FirebaseAuthService authService;
  final ImageType imageType;

  ProfileViewModel({
    required this.storageService,
    required this.authService,
    required this.imageType,
  });

  File? imageFile;
  String? imageUrl;
  bool isLoading = false;

  // =============================
  // Pick Image
  // =============================
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxWidth: 600,
        maxHeight: 600,
      );

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  // =============================
  // Upload Image
  // =============================

  Future<bool> uploadImage({String? groupId}) async {
    if (imageFile == null) return false;

    isLoading = true;

    try {
      final userId = authService.getCurrentUser()!.uid;

      if (imageType == ImageType.group && groupId == null) throw 'no group id';

      final url = imageType == ImageType.user
          ? await storageService.uploadUserImage(
              file: imageFile!,
              userId: userId,
            )
          : await storageService.uploadGroupImage(
              file: imageFile!,
              groupId: groupId!,
            );

      if (url != null && url.isNotEmpty) {
        imageUrl = url;
        imageFile = null;
        notifyListeners();
        return true;
      } else {
        throw Exception("Upload failed");
      }
    } catch (e) {
      log('Upload error: $e');
      imageFile = null;
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
    }
  }

  // =============================
  // Load Profile Image
  // =============================

  Future<void> loadProfileImage() async {
    try {
      final userId = authService.getCurrentUser()!.uid;
      final url = storageService.getUserImageUrl(userId);
      imageUrl = url.isNotEmpty ? url : null;
      notifyListeners();
    } catch (e) {
      log('Error loading image: $e');
    }
  }

  // =============================
  // Load Group Image
  // =============================

  Future<void> loadGroupImage(String groupId) async {
    try {
      final url = storageService.getGroupImageUrl(groupId);
      imageUrl = url.isNotEmpty ? url : null;
      notifyListeners();
    } catch (e) {
      log('Error loading image: $e');
    }
  }
}
