enum CheckInStatus { success, fail, pending }

class CheckInModel {
  final String userId;
  final String date; 
  final CheckInStatus status;
  final String? messagePublic;
  final DateTime createdAt;

  CheckInModel({
    required this.userId,
    required this.date,
    required this.status,
    this.messagePublic,
    required this.createdAt,
  });

  factory CheckInModel.fromMap(Map<String, dynamic> map) {
    return CheckInModel(
      userId: map['userId'],
      date: map['date'],
      status: CheckInStatus.values.firstWhere(
        (e) => e.name == map['status'],
      ),
      messagePublic: map['messagePublic'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'status': status.name,
      'messagePublic': messagePublic,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
