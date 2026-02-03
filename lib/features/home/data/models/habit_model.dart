class HabitModel {
  final String id;
  final String title;
  final String createdBy;
  final List<String> participants;
  final DateTime createdAt;
  final bool isActive;

  HabitModel({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.participants,
    required this.createdAt,
    required this.isActive,
  });

  factory HabitModel.fromMap(String id, Map<String, dynamic> map) {
    return HabitModel(
      id: id,
      title: map['title'] ?? '',
      createdBy: map['createdBy'],
      participants: List<String>.from(map['participants'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdBy': createdBy,
      'participants': participants,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }
}
