/// 리워드 모델
class Reward {
  final int? id;
  final String
  type; // 'daily_bonus', 'ad_reward', 'study_complete', 'achievement'
  final int amount;
  final String? description;
  final DateTime earnedAt;

  Reward({
    this.id,
    required this.type,
    required this.amount,
    this.description,
    required this.earnedAt,
  });
}

/// 사용자 포인트/코인 잔액
class UserBalance {
  final int totalPoints;
  final int usedPoints;
  final int availablePoints;
  final DateTime lastUpdated;

  UserBalance({
    required this.totalPoints,
    required this.usedPoints,
    required this.lastUpdated,
  }) : availablePoints = totalPoints - usedPoints;

  factory UserBalance.empty() {
    return UserBalance(
      totalPoints: 0,
      usedPoints: 0,
      lastUpdated: DateTime.now(),
    );
  }
}

/// 리워드 타입 상수
class RewardType {
  static const String dailyBonus = 'daily_bonus';
  static const String adReward = 'ad_reward';
  static const String studyComplete = 'study_complete';
  static const String achievement = 'achievement';
  static const String notificationRead = 'notification_read';
  static const String categoryOrganize = 'category_organize';
}

/// 리워드 금액 상수
class RewardAmount {
  static const int dailyBonus = 50;
  static const int adReward = 100;
  static const int studyComplete = 10;
  static const int achievement = 200;
  static const int notificationRead = 5;
  static const int categoryOrganize = 20;
}
