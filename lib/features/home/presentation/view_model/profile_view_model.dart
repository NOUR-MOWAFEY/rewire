import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewire/core/services/firebase_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final SupabaseStorageService storageService;
  final FirebaseAuthService authService;

  ProfileViewModel({required this.storageService, required this.authService});

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
      );

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  // =============================
  // Upload Image
  // =============================
  Future<bool?> uploadImage() async {
    if (imageFile == null) return null;

    isLoading = true;
    notifyListeners();

    try {
      final userId = authService.getCurrentUser()!.uid;

      final url = await storageService.uploadUserImage(
        file: imageFile!,
        userId: userId,
      );

      if (url != null && url.isNotEmpty) {
        imageUrl = url;
        imageFile = null;
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
      notifyListeners();
    }
  }

  // =============================
  // Load Image
  // =============================
  Future<void> loadImage() async {
    try {
      final userId = authService.getCurrentUser()!.uid;
      final url = storageService.getUserImageUrl(userId);
      imageUrl = url.isNotEmpty ? url : null;
      notifyListeners();
    } catch (e) {
      log('Error loading image: $e');
    }
  }
}
