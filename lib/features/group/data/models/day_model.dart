import 'package:cloud_firestore/cloud_firestore.dart';

class DayModel {
  final String day; // yyyy-MM-dd
  final DateTime? updatedAt;

  DayModel({required this.day, this.updatedAt});

  factory DayModel.fromMap(Map<String, dynamic> map) {
    return DayModel(
      day: map['day'] ?? '',
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'updatedAt': updatedAt != null
          ? Timestamp.fromDate(updatedAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  DayModel copyWith({String? day, DateTime? updatedAt}) {
    return DayModel(
      day: day ?? this.day,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
