enum CheckInStatus { success, fail, pending }

class CheckInModel {
  final String userId;
  final String groupId;
  final String date;
  final CheckInStatus status;
  final String? messagePublic;
  final DateTime createdAt;

  CheckInModel({
    required this.userId,
    required this.groupId,
    required this.date,
    required this.status,
    this.messagePublic,
    required this.createdAt,
  });

  factory CheckInModel.fromMap(Map<String, dynamic> map) {
    return CheckInModel(
      userId: map['userId'],
      groupId: map['groupId'] ?? '',
      date: map['date'],
      status: CheckInStatus.values.firstWhere((e) => e.name == map['status']),
      messagePublic: map['messagePublic'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'groupId': groupId,
      'date': date,
      'status': status.name,
      'messagePublic': messagePublic,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static CheckInModel fakeData() {
    return CheckInModel(
      userId: '',
      groupId: '',
      date: '',
      status: CheckInStatus.pending,
      createdAt: DateTime(2000),
    );
  }
}
