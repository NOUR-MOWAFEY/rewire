import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rewire/features/profile_view/data/models/user_model.dart';

class UserFirestoreService {
  final FirebaseFirestore _firestore;

  UserFirestoreService(this._firestore);

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void clearCache() {
    _currentUser = null;
  }

  // =====================
  // Collections
  // =====================

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  // =====================
  // Users
  // =====================

  Future<void> createUser(UserModel user) async {
    await _users.doc(user.uid).set(user.toMap());
    _currentUser = user;
  }

  Future<UserModel?> getUser(String uid) async {
    // Return from cache if available
    if (_currentUser?.uid == uid) return _currentUser;

    final doc = await _users.doc(uid).get();
    if (!doc.exists) return null;

    final user = UserModel.fromMap(doc.id, doc.data()!);

    // Cache the first fetched user (typically the current user)
    _currentUser ??= user;

    return user;
  }

  Future<void> updateUser(UserModel user) async {
    await _users.doc(user.uid).update(user.toMap());
    if (_currentUser?.uid == user.uid) {
      _currentUser = user;
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final query = await _users
        .where('email', isEqualTo: email.trim().toLowerCase())
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return UserModel.fromMap(query.docs.first.id, query.docs.first.data());
  }

  Stream<UserModel?> listenToUser(String userId) {
    return _users.doc(userId).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      final user = UserModel.fromMap(snapshot.id, snapshot.data()!);
      _currentUser = user; // Update cache
      return user;
    });
  }
}
