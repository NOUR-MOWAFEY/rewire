class PrivateMessageModel {
  final String habitId;
  final String date;
  final String note;

  PrivateMessageModel({
    required this.habitId,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'habitId': habitId,
      'date': date,
      'note': note,
    };
  }

  factory PrivateMessageModel.fromMap(Map<String, dynamic> map) {
    return PrivateMessageModel(
      habitId: map['habitId'],
      date: map['date'],
      note: map['note'],
    );
  }
}
