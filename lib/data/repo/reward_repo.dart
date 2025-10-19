import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/data/models/reward.dart' as model;

class RewardRepo {
  final AppDatabase _db;

  RewardRepo(this._db);

  /// 리워드 지급
  Future<bool> grantReward({
    required String type,
    required int amount,
    String? description,
  }) async {
    try {
      // 1. 리워드 기록 추가
      await _db
          .into(_db.rewards)
          .insert(
            RewardsCompanion.insert(
              type: type,
              amount: amount,
              description: Value(description),
              earnedAt: DateTime.now().millisecondsSinceEpoch,
            ),
          );

      // 2. 사용자 잔액 업데이트
      await _updateBalance(amount);

      debugPrint('리워드 지급: $type ($amount포인트)');
      return true;
    } catch (e) {
      debugPrint('리워드 지급 실패: $e');
      return false;
    }
  }

  /// 사용자 잔액 업데이트
  Future<void> _updateBalance(int amount) async {
    final existing = await (_db.select(
      _db.userBalance,
    )..where((t) => t.id.equals(1))).getSingleOrNull();

    if (existing == null) {
      // 첫 잔액 생성
      await _db
          .into(_db.userBalance)
          .insert(
            UserBalanceCompanion.insert(
              id: const Value(1),
              totalPoints: Value(amount),
              usedPoints: const Value(0),
              lastUpdated: DateTime.now().millisecondsSinceEpoch,
            ),
          );
    } else {
      // 기존 잔액 업데이트
      await (_db.update(_db.userBalance)..where((t) => t.id.equals(1))).write(
        UserBalanceCompanion(
          totalPoints: Value(existing.totalPoints + amount),
          lastUpdated: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );
    }
  }

  /// 포인트 사용
  Future<bool> usePoints(int amount, {String? description}) async {
    try {
      final balance = await getBalance();

      if (balance.availablePoints < amount) {
        debugPrint('포인트 부족: 필요 $amount, 보유 ${balance.availablePoints}');
        return false;
      }

      // 사용 포인트 업데이트
      await (_db.update(_db.userBalance)..where((t) => t.id.equals(1))).write(
        UserBalanceCompanion(
          usedPoints: Value(balance.usedPoints + amount),
          lastUpdated: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );

      // 사용 기록 (음수로 저장)
      await _db
          .into(_db.rewards)
          .insert(
            RewardsCompanion.insert(
              type: 'use_points',
              amount: -amount,
              description: Value(description ?? '포인트 사용'),
              earnedAt: DateTime.now().millisecondsSinceEpoch,
            ),
          );

      debugPrint('포인트 사용: $amount포인트');
      return true;
    } catch (e) {
      debugPrint('포인트 사용 실패: $e');
      return false;
    }
  }

  /// 현재 잔액 조회
  Future<model.UserBalance> getBalance() async {
    final balance = await (_db.select(
      _db.userBalance,
    )..where((t) => t.id.equals(1))).getSingleOrNull();

    if (balance == null) {
      return model.UserBalance.empty();
    }

    return model.UserBalance(
      totalPoints: balance.totalPoints,
      usedPoints: balance.usedPoints,
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(balance.lastUpdated),
    );
  }

  /// 리워드 히스토리 조회
  Future<List<model.Reward>> getRewardHistory({int limit = 50}) async {
    final rewards =
        await (_db.select(_db.rewards)
              ..orderBy([(t) => OrderingTerm.desc(t.earnedAt)])
              ..limit(limit))
            .get();

    return rewards
        .map(
          (r) => model.Reward(
            id: r.id,
            type: r.type,
            amount: r.amount,
            description: r.description,
            earnedAt: DateTime.fromMillisecondsSinceEpoch(r.earnedAt),
          ),
        )
        .toList();
  }

  /// 오늘 일일 보너스를 받았는지 확인
  Future<bool> hasDailyBonusToday() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final startTimestamp = startOfDay.millisecondsSinceEpoch;

    final count =
        await (_db.select(_db.rewards)..where(
              (t) =>
                  t.type.equals(model.RewardType.dailyBonus) &
                  t.earnedAt.isBiggerOrEqualValue(startTimestamp),
            ))
            .get();

    return count.isNotEmpty;
  }

  /// 특정 타입의 리워드 개수 조회
  Future<int> getRewardCount(String type) async {
    final count = await (_db.select(
      _db.rewards,
    )..where((t) => t.type.equals(type))).get();
    return count.length;
  }

  /// 총 획득 리워드 합계
  Future<int> getTotalEarnedPoints() async {
    final rewards = await _db.select(_db.rewards).get();
    return rewards.fold<int>(
      0,
      (sum, r) => sum + (r.amount > 0 ? r.amount : 0),
    );
  }
}
