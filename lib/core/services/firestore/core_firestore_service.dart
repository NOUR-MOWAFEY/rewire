import 'package:cloud_firestore/cloud_firestore.dart';

class CoreFirestoreService {
  final FirebaseFirestore _firestore;

  CoreFirestoreService(this._firestore);

  // =====================
  // Today Date
  // =====================

  Future<void> updateToday() async {
    await _firestore.collection('core').doc('date').set({
      'today': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getToday() async {
    var day = await _firestore.collection('core').doc('date').get();
    return day;
  }
}
