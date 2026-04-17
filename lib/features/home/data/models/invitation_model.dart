import 'package:cloud_firestore/cloud_firestore.dart';

enum InvitationStatus { pending, accepted, declined }

class InvitationModel {
  final String id;
  final String groupId;
  final String groupName;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String receiverName;
  final String receiverEmail;
  final InvitationStatus status;
  final Timestamp createdAt;

  InvitationModel({
    required this.id,
    required this.groupId,
    required this.groupName,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.receiverEmail,
    required this.status,
    required this.createdAt,
  });

  factory InvitationModel.fromMap(String id, Map<String, dynamic> map) {
    return InvitationModel(
      id: id,
      groupId: map['groupId'] ?? '',
      groupName: map['groupName'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverName: map['receiverName'] ?? '',
      receiverEmail: map['receiverEmail'] ?? '',
      status: InvitationStatus.values.firstWhere(
        (e) => e.name == (map['status'] ?? 'pending'),
        orElse: () => InvitationStatus.pending,
      ),
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'receiverEmail': receiverEmail,
      'status': status.name,
      'createdAt': createdAt,
    };
  }

  static InvitationModel fakeData() {
    return InvitationModel(
      id: '0000000',
      groupId: 'groupId',
      groupName: 'groupName',
      senderId: 'senderId',
      senderName: 'senderName',
      receiverId: 'receiverId',
      receiverName: 'receiverName',
      receiverEmail: 'receiverEmail',
      status: InvitationStatus.pending,
      createdAt: Timestamp.now(),
    );
  }
}
