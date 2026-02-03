class UserModel {
  final String uid;
  final String name;
  final String email;
  final DateTime joinedAt;
  final int overallScore;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.joinedAt,
    required this.overallScore,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      joinedAt: DateTime.parse(map['joinedAt']),
      overallScore: map['overallScore'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'joinedAt': joinedAt.toIso8601String(),
      'overallScore': overallScore,
    };
  }
}
