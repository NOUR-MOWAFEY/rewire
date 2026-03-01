import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/services/supabase_storage_service.dart';

part 'delete_group_state.dart';

class DeleteGroupCubit extends Cubit<DeleteGroupState> {
  DeleteGroupCubit(
    this._firestoreService, {
    required SupabaseStorageService supabaseStorageService,
  }) : _supabaseStorageService = supabaseStorageService,
       super(DeleteGroupInitial());

  final FirestoreService _firestoreService;
  final SupabaseStorageService _supabaseStorageService;

  bool isLoading = false;

  // =====================
  // Delete Group
  // =====================

  Future<void> deleteGroup(String groupId) async {
    isLoading = true;
    emit(DeleteGroupLoading());

    try {
      await _firestoreService
          .deleteGroup(groupId)
          .timeout(
            Duration(seconds: 10),
            onTimeout: () => throw 'Connection timeout',
          );

      await _supabaseStorageService.deleteGroupImage(groupId);

      if (!isClosed) emit(DeleteGroupSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(DeleteGroupFailure(errMessage: e.toString()));
    } finally {
      isLoading = false;
    }
  }
}
