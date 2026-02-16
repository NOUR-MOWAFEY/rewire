import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient _client = Supabase.instance.client;

  static const String _bucketName = 'images';

  /// ============================
  /// Upload User Image (userId as name)
  /// ============================
  Future<String?> uploadUserImage({
    required File file,
    required String userId,
  }) async {
    try {
      final filePath = 'users/$userId.jpg';

      await _client.storage
          .from(_bucketName)
          .upload(
            filePath,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      final publicUrl = _client.storage
          .from(_bucketName)
          .getPublicUrl(filePath);

      final updatedUrl =
          '$publicUrl?t=${DateTime.now().millisecondsSinceEpoch}';

      return updatedUrl;
    } catch (e) {
      log('Upload Error: $e');
      return null;
    }
  }

  /// ============================
  /// Delete User Image
  /// ============================
  Future<bool> deleteUserImage(String userId) async {
    try {
      final filePath = 'users/$userId.jpg';

      await _client.storage.from(_bucketName).remove([filePath]);

      return true;
    } catch (e) {
      log('Delete Error: $e');
      return false;
    }
  }

  /// ============================
  /// Update User Image
  /// ============================
  Future<String?> updateUserImage({
    required File newFile,
    required String userId,
  }) async {
    return await uploadUserImage(file: newFile, userId: userId);
  }

  /// ============================
  /// Get User Image URL
  /// ============================
  String getUserImageUrl(String userId) {
    final filePath = 'users/$userId.jpg';

    final publicUrl = _client.storage.from(_bucketName).getPublicUrl(filePath);

    return '$publicUrl?t=${DateTime.now().millisecondsSinceEpoch}';
  }
}
