import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';

part 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  MembersCubit() : super(MembersInitial());

  bool isLoading = false;

  final _firestoreService = getIt.get<FirestoreService>();

  final Set<String> members = {};

  // get member by email

  Future<void> getMemberByEmail(String email, String currentUserId) async {
    emit(MembersLoading());
    isLoading = true;

    try {
      final user = await _firestoreService.getUserByEmail(email);

      if (user == null) {
        emit(MembersError(errMassage: "No user found with this email"));
        return;
      }

      if (user.uid == currentUserId) {
        emit(MembersError(errMassage: "You can't add yourself"));
        return;
      }

      if (members.contains(user.uid)) {
        emit(MembersError(errMassage: "User is already a member"));
      }

      emit(MembersFound(userId: user.uid));
    } on Exception catch (e) {
      emit(MembersError(errMassage: e.toString()));
    } finally {
      isLoading = false;
    }
  }

  // add user by email

  Future<void> addMemberByEmail({
    required String groupId,
    required List<String> currentMembers, // from your loaded GroupModel
    required String email,
  }) async {
    emit(MembersLoading());

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

      emit(MembersAdded());
    } on Exception catch (e) {
      emit(MembersError(errMassage: e.toString()));
    }
  }
}
