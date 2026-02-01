import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _user = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(
    String email,
    String name,
    userId,
  ) async {
    await _user.doc(userId).set({
      'user_id': userId,
      'name': name,
      'email': email,
      'joined_at':FieldValue.serverTimestamp()
    });
  }
}
