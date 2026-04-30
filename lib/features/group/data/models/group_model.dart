import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String id;
  final String name;
  final String createdBy;
  final List<String> members;
  final Map<String, num> memberCommitments;
  final Timestamp? createdAt;
  final bool isActive;

  final String joinCode;
  final String passwordHash;

  final int? imageUpdatedAt;

  GroupModel({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.members,
    Map<String, num>? memberCommitments,
    this.createdAt,
    required this.isActive,
    required this.joinCode,
    required this.passwordHash,
    this.imageUpdatedAt,
  }) : memberCommitments = memberCommitments ?? {};

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      createdBy: map['createdBy'],
      members: List<String>.from(map['members'] ?? []),
      memberCommitments: Map<String, num>.from(map['memberCommitments'] ?? {}),
      createdAt: map['createdAt'],
      isActive: map['isActive'] ?? true,
      joinCode: map['joinCode'] ?? '',
      passwordHash: map['passwordHash'] ?? '',
      imageUpdatedAt: map['imageUpdatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdBy': createdBy,
      'members': members,
      'memberCommitments': memberCommitments,
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': isActive,
      'joinCode': joinCode,
      'passwordHash': passwordHash,
      if (imageUpdatedAt != null) 'imageUpdatedAt': imageUpdatedAt,
    };
  }

  GroupModel copyWith({
    String? id,
    String? name,
    String? createdBy,
    List<String>? members,
    Map<String, num>? memberCommitments,
    bool? isActive,
    String? joinCode,
    String? passwordHash,
    int? imageUpdatedAt,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? this.members,
      memberCommitments: memberCommitments ?? this.memberCommitments,
      createdAt: createdAt,
      isActive: isActive ?? this.isActive,
      joinCode: joinCode ?? this.joinCode,
      passwordHash: passwordHash ?? this.passwordHash,
      imageUpdatedAt: imageUpdatedAt ?? this.imageUpdatedAt,
    );
  }

  static GroupModel fakeData() {
    return GroupModel(
      id: '00000000',
      name: 'name',
      createdBy: 'createdBy',
      members: ['members', '', '', ''],
      isActive: true,
      joinCode: 'joinCode',
      passwordHash: 'passwordHash',
    );
  }
}
