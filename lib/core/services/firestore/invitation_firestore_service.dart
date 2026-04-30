import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rewire/features/invitations/data/models/invitation_model.dart';

import 'checkin_firestore_service.dart';

class InvitationFirestoreService {
  final FirebaseFirestore _firestore;
  final CheckinFirestoreService _checkinService;

  InvitationFirestoreService(this._firestore, this._checkinService);

  // =====================
  // Collections
  // =====================

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('habits');

  CollectionReference<Map<String, dynamic>> get _invitations =>
      _firestore.collection('invitations');

  // =====================
  // Invitations
  // =====================

  Future<void> sendInvitation(InvitationModel invitation) async {
    // Check if invitation already exists
    final existing = await _invitations
        .where('groupId', isEqualTo: invitation.groupId)
        .where('receiverId', isEqualTo: invitation.receiverId)
        .where('status', isEqualTo: InvitationStatus.pending.name)
        .get();

    if (existing.docs.isNotEmpty) {
      throw 'An invitation is already pending for this user';
    }

    // Use model's toMap() and override createdAt with a server timestamp
    await _invitations.add({
      ...invitation.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<InvitationModel>> listenToInvitations(String userId) {
    return _invitations
        .where('receiverId', isEqualTo: userId)
        .where('status', isEqualTo: InvitationStatus.pending.name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => InvitationModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> respondToInvitation({
    required InvitationModel invitation,
    required bool accept,
  }) async {
    if (accept) {
      // Add to members array in group
      await _groups.doc(invitation.groupId).update({
        'members': FieldValue.arrayUnion([invitation.receiverId]),
        'memberCommitments.${invitation.receiverId}': 0,
      });

      // Initialize today's check-in for the new member
      await _checkinService.createDayIfNotExist(
        habitId: invitation.groupId,
        userId: invitation.receiverId,
      );
    }

    // Delete invitation regardless of accept/decline
    await _invitations.doc(invitation.id).delete();
  }

  Stream<List<InvitationModel>> listenToGroupInvitations(String groupId) {
    return _invitations
        .where('groupId', isEqualTo: groupId)
        .where('status', isEqualTo: InvitationStatus.pending.name)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => InvitationModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> cancelInvitation(String invitationId) async {
    await _invitations.doc(invitationId).delete();
  }
}
