import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  // final String id;
  final String title;
  final String createdBy;
  final List<String> participants;
  final Timestamp? createdAt;
  final bool isActive;

  HabitModel({
    // required this.id,
    required this.title,
    required this.createdBy,
    required this.participants,
    this.createdAt,
    required this.isActive,
  });

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      // id: id,
      title: map['title'] ?? '',
      createdBy: map['createdBy'],
      participants: List<String>.from(map['participants'] ?? []),
      createdAt: map['createdAt'],
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdBy': createdBy,
      'participants': participants,
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': isActive,
    };
  }
}
