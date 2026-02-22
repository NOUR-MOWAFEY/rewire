import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  final String id;
  final String title;
  final String createdBy;
  final List<String> participants;
  final Timestamp? createdAt;
  final bool isActive;

  HabitModel({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.participants,
    this.createdAt,
    required this.isActive,
  });

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      createdBy: map['createdBy'],
      participants: List<String>.from(map['participants'] ?? []),
      createdAt: map['createdAt'],
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdBy': createdBy,
      'participants': participants,
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': isActive,
    };
  }

  HabitModel copyWith({
    String? id,
    String? title,
    String? createdBy,
    List<String>? participants,
    bool? isActive,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdBy: createdBy ?? this.createdBy,
      participants: participants ?? this.participants,
      isActive: isActive ?? this.isActive,
    );
  }
}
