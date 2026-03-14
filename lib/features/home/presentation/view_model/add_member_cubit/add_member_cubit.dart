import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';

part 'add_member_state.dart';

class AddMemberCubit extends Cubit<AddMemberState> {
  AddMemberCubit() : super(AddMemberInitial());

  final _firestoreService = getIt.get<FirestoreService>();

  // add user by email

  Future<void> addMemberByEmail({
    required String groupId,
    required List<String> currentMembers, // from your loaded GroupModel
    required String email,
  }) async {
    emit(AddMemberLoading());

    try {
      // Find user
      final user = await _firestoreService.getUserByEmail(email);
      if (user == null) throw Exception("No user found with this email");

      // Check duplicate
      if (currentMembers.contains(user.uid)) {
        throw Exception("This user is already a member");
      }

      // Add
      await _firestoreService.addMembers(groupId: groupId, userId: user.uid);

      emit(AddMemberSuccess());
    } on Exception catch (e) {
      emit(AddMemberFailure(errMassage: e.toString()));
    }
  }
}
