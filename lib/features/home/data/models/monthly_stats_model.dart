class MonthlyStatsModel {
  final String month; // YYYY-MM
  final int successDays;
  final int failDays;
  final int pendingDays;
  final int commitmentRate;

  MonthlyStatsModel({
    required this.month,
    required this.successDays,
    required this.failDays,
    required this.pendingDays,
    required this.commitmentRate,
  });

  factory MonthlyStatsModel.fromMap(Map<String, dynamic> map) {
    return MonthlyStatsModel(
      month: map['month'],
      successDays: map['successDays'] ?? 0,
      failDays: map['failDays'] ?? 0,
      pendingDays: map['pendingDays'] ?? 0,
      commitmentRate: map['commitmentRate'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'successDays': successDays,
      'failDays': failDays,
      'pendingDays': pendingDays,
      'commitmentRate': commitmentRate,
    };
  }
}
