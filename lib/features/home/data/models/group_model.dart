import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String id;
  final String title;
  final String createdBy;
  final List<String> participants;
  final Timestamp? createdAt;
  final bool isActive;

  final String joinCode;
  final String passwordHash;

  GroupModel({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.participants,
    this.createdAt,
    required this.isActive,
    required this.joinCode,
    required this.passwordHash,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      createdBy: map['createdBy'],
      participants: List<String>.from(map['participants'] ?? []),
      createdAt: map['createdAt'],
      isActive: map['isActive'] ?? true,
      joinCode: map['joinCode'] ?? '',
      passwordHash: map['passwordHash'] ?? '',
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
      'joinCode': joinCode,
      'passwordHash': passwordHash,
    };
  }

  GroupModel copyWith({
    String? id,
    String? title,
    String? createdBy,
    List<String>? participants,
    bool? isActive,
    String? joinCode,
    String? passwordHash,
  }) {
    return GroupModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdBy: createdBy ?? this.createdBy,
      participants: participants ?? this.participants,
      createdAt: createdAt,
      isActive: isActive ?? this.isActive,
      joinCode: joinCode ?? this.joinCode,
      passwordHash: passwordHash ?? this.passwordHash,
    );
  }
}