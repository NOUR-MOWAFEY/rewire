import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rewire/features/group/data/models/public_message_model.dart';

class MessageFirestoreService {
  final FirebaseFirestore _firestore;

  MessageFirestoreService(this._firestore);

  // =====================
  // Collections
  // =====================

  CollectionReference<Map<String, dynamic>> get _groups =>
      _firestore.collection('habits');

  // =====================
  // Public Messages
  // =====================

  Future<void> addPublicMessage({
    required String habitId,
    required PublicMessageModel message,
  }) async {
    await _groups.doc(habitId).collection('messages').add(message.toMap());
  }

  Future<List<PublicMessageModel>> getMessages(String habitId) async {
    final query = await _groups
        .doc(habitId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs
        .map((doc) => PublicMessageModel.fromMap(doc.id, doc.data()))
        .toList();
  }
}
