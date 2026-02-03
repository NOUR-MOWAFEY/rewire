class PublicMessageModel {
  final String id;
  final String userId;
  final String text;
  final String date;
  final DateTime createdAt;

  PublicMessageModel({
    required this.id,
    required this.userId,
    required this.text,
    required this.date,
    required this.createdAt,
  });

  factory PublicMessageModel.fromMap(String id, Map<String, dynamic> map) {
    return PublicMessageModel(
      id: id,
      userId: map['userId'],
      text: map['text'],
      date: map['date'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'text': text,
      'date': date,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
