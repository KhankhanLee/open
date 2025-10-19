import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/data/models/category.dart';
import 'package:yeolda/services/classifier.dart';
import 'package:yeolda/services/notification_listener.dart';

class NotificationRepo {
  final AppDatabase _db;
  final ClassifierService _classifier;

  NotificationRepo(this._db, this._classifier);

  /// 수신한 알림을 분류하고 DB에 저장
  Future<bool> insertNotification(IncomingNotification incoming) async {
    // 분류
    final classification = await _classifier.classify(
      packageName: incoming.packageName,
      title: incoming.title,
      content: incoming.text,
      category: incoming.category,
    );

    // 해시 생성
    final hash = incoming.generateHash();

    // 커스텀 카테고리가 있으면 그 이름을, 없으면 enum 이름을 사용
    final categoryName =
        classification.customCategory?.name ?? classification.category.name;

    try {
      await _db
          .into(_db.notificationEntries)
          .insert(
            NotificationEntriesCompanion.insert(
              postedAt: incoming.postedAt,
              packageName: incoming.packageName,
              appLabel: incoming.appLabel,
              title: incoming.title,
              content: Value(incoming.text),
              channelId: Value(incoming.channelId),
              category: Value(incoming.category),
              assignedCategory: categoryName,
              isImportant: Value(classification.isImportant),
              isRead: const Value(false),
              hash: hash,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      return true;
    } catch (e) {
      debugPrint('Error inserting notification: $e');
      return false;
    }
  }

  /// 타임라인 쿼리
  Future<List<NotificationEntry>> queryTimeline({
    AppCategory? category,
    String? packageName,
    DateTime? from,
    DateTime? to,
    bool? important,
    bool? unread,
    int limit = 100,
    int offset = 0,
  }) async {
    final query = _db.select(_db.notificationEntries)
      ..orderBy([
        (t) => OrderingTerm(expression: t.postedAt, mode: OrderingMode.desc),
      ])
      ..limit(limit, offset: offset);

    if (category != null) {
      query.where((t) => t.assignedCategory.equals(category.name));
    }

    if (packageName != null) {
      query.where((t) => t.packageName.equals(packageName));
    }

    if (from != null) {
      query.where(
        (t) => t.postedAt.isBiggerOrEqualValue(from.millisecondsSinceEpoch),
      );
    }

    if (to != null) {
      query.where(
        (t) => t.postedAt.isSmallerOrEqualValue(to.millisecondsSinceEpoch),
      );
    }

    if (important != null && important) {
      query.where((t) => t.isImportant.equals(true));
    }

    if (unread != null && unread) {
      query.where((t) => t.isRead.equals(false));
    }

    return await query.get();
  }

  /// 알림을 읽음 처리
  Future<void> markAsRead(int id) async {
    await (_db.update(_db.notificationEntries)..where((t) => t.id.equals(id)))
        .write(const NotificationEntriesCompanion(isRead: Value(true)));
  }

  /// 중요 표시 토글
  Future<void> toggleImportant(int id, bool isImportant) async {
    await (_db.update(_db.notificationEntries)..where((t) => t.id.equals(id)))
        .write(NotificationEntriesCompanion(isImportant: Value(isImportant)));
  }

  /// 앱별 통계 (상위 N개)
  Future<List<AppStat>> getTopApps(int limit) async {
    final query = '''
      SELECT package_name, app_label, COUNT(*) as count
      FROM notification_entries
      GROUP BY package_name
      ORDER BY count DESC
      LIMIT ?
    ''';

    final result = await _db
        .customSelect(
          query,
          variables: [Variable.withInt(limit)],
          readsFrom: {_db.notificationEntries},
        )
        .get();

    return result.map((row) {
      return AppStat(
        packageName: row.read<String>('package_name'),
        appLabel: row.read<String>('app_label'),
        count: row.read<int>('count'),
      );
    }).toList();
  }

  /// 시간대별 통계 (0-23시)
  Future<Map<int, int>> getStatsByHour() async {
    final query = '''
      SELECT 
        CAST(strftime('%H', posted_at / 1000, 'unixepoch', 'localtime') AS INTEGER) as hour,
        COUNT(*) as count
      FROM notification_entries
      GROUP BY hour
      ORDER BY hour
    ''';

    final result = await _db
        .customSelect(query, readsFrom: {_db.notificationEntries})
        .get();

    final stats = <int, int>{};
    for (final row in result) {
      final hour = row.read<int>('hour');
      final count = row.read<int>('count');
      stats[hour] = count;
    }

    return stats;
  }

  /// 요일별 통계 (0=월요일, 6=일요일)
  Future<Map<int, int>> getStatsByWeekday() async {
    // SQLite의 strftime을 사용
    // %w: 0=일요일, 1=월요일, ..., 6=토요일
    // 변환: (weekday + 6) % 7 = 0=월요일, 1=화요일, ..., 6=일요일
    final query = '''
      SELECT 
        (CAST(strftime('%w', posted_at / 1000, 'unixepoch', 'localtime') AS INTEGER) + 6) % 7 as weekday,
        COUNT(*) as count
      FROM notification_entries
      GROUP BY weekday
      ORDER BY weekday
    ''';

    final result = await _db
        .customSelect(query, readsFrom: {_db.notificationEntries})
        .get();

    final stats = <int, int>{};
    for (final row in result) {
      final weekday = row.read<int>('weekday');
      final count = row.read<int>('count');
      stats[weekday] = count;
    }

    return stats;
  }

  /// 카테고리별 통계
  Future<Map<AppCategory, int>> getStatsByCategory() async {
    final query = '''
      SELECT assigned_category, COUNT(*) as count
      FROM notification_entries
      GROUP BY assigned_category
    ''';

    final result = await _db
        .customSelect(query, readsFrom: {_db.notificationEntries})
        .get();

    final stats = <AppCategory, int>{};
    for (final row in result) {
      final categoryName = row.read<String>('assigned_category');
      final count = row.read<int>('count');
      final category = AppCategory.values.firstWhere(
        (c) => c.name == categoryName,
        orElse: () => AppCategory.other,
      );
      stats[category] = count;
    }

    return stats;
  }

  /// 총 알림 수
  Future<int> getTotalCount() async {
    final query = _db.selectOnly(_db.notificationEntries)
      ..addColumns([_db.notificationEntries.id.count()]);

    final result = await query.getSingle();
    return result.read(_db.notificationEntries.id.count()) ?? 0;
  }

  /// 읽지 않은 알림 수
  Future<int> getUnreadCount() async {
    final query = _db.selectOnly(_db.notificationEntries)
      ..addColumns([_db.notificationEntries.id.count()])
      ..where(_db.notificationEntries.isRead.equals(false));

    final result = await query.getSingle();
    return result.read(_db.notificationEntries.id.count()) ?? 0;
  }

  /// 모든 알림 삭제
  Future<void> deleteAll() async {
    await _db.delete(_db.notificationEntries).go();
  }

  /// 특정 기간 이전 알림 삭제
  Future<void> deleteOlderThan(DateTime date) async {
    await (_db.delete(_db.notificationEntries)..where(
          (t) => t.postedAt.isSmallerThanValue(date.millisecondsSinceEpoch),
        ))
        .go();
  }

  /// 모든 고유 패키지명과 앱 라벨 가져오기
  Future<List<AppInfo>> getAllApps() async {
    final result =
        await (_db.selectOnly(_db.notificationEntries)
              ..addColumns([
                _db.notificationEntries.packageName,
                _db.notificationEntries.appLabel,
              ])
              ..groupBy([
                _db.notificationEntries.packageName,
                _db.notificationEntries.appLabel,
              ])
              ..orderBy([
                OrderingTerm(expression: _db.notificationEntries.appLabel),
              ]))
            .get();

    return result.map((row) {
      return AppInfo(
        packageName: row.read(_db.notificationEntries.packageName)!,
        appLabel: row.read(_db.notificationEntries.appLabel)!,
      );
    }).toList();
  }

  /// 모든 알림을 재분류 (커스텀 카테고리 변경 시 호출)
  Future<int> reclassifyAllNotifications() async {
    debugPrint('모든 알림 재분류 시작...');

    // 모든 알림 가져오기
    final allNotifications = await (_db.select(
      _db.notificationEntries,
    )..orderBy([(t) => OrderingTerm(expression: t.id)])).get();

    int updatedCount = 0;

    for (final notification in allNotifications) {
      try {
        // 재분류
        final classification = await _classifier.classify(
          packageName: notification.packageName,
          title: notification.title,
          content: notification.content ?? '',
          category: notification.category,
        );

        // 새로운 카테고리명
        final newCategoryName =
            classification.customCategory?.name ?? classification.category.name;

        // 카테고리가 변경된 경우에만 업데이트
        if (newCategoryName != notification.assignedCategory) {
          await (_db.update(
            _db.notificationEntries,
          )..where((t) => t.id.equals(notification.id))).write(
            NotificationEntriesCompanion(
              assignedCategory: Value(newCategoryName),
            ),
          );

          updatedCount++;
          debugPrint(
            '재분류: ${notification.appLabel} (${notification.assignedCategory} → $newCategoryName)',
          );
        }
      } catch (e) {
        debugPrint('재분류 실패: ${notification.appLabel} - $e');
      }
    }

    debugPrint('재분류 완료: $updatedCount/${allNotifications.length}개 업데이트됨');
    return updatedCount;
  }

  /// 특정 패키지의 알림만 재분류
  Future<int> reclassifyByPackage(String packageName) async {
    debugPrint('패키지별 재분류 시작: $packageName');

    final notifications = await (_db.select(
      _db.notificationEntries,
    )..where((t) => t.packageName.equals(packageName))).get();

    int updatedCount = 0;

    for (final notification in notifications) {
      try {
        final classification = await _classifier.classify(
          packageName: notification.packageName,
          title: notification.title,
          content: notification.content ?? '',
          category: notification.category,
        );

        final newCategoryName =
            classification.customCategory?.name ?? classification.category.name;

        if (newCategoryName != notification.assignedCategory) {
          await (_db.update(
            _db.notificationEntries,
          )..where((t) => t.id.equals(notification.id))).write(
            NotificationEntriesCompanion(
              assignedCategory: Value(newCategoryName),
            ),
          );

          updatedCount++;
        }
      } catch (e) {
        debugPrint('재분류 실패: $e');
      }
    }

    debugPrint('재분류 완료: $updatedCount/${notifications.length}개 업데이트됨');
    return updatedCount;
  }
}

class AppStat {
  final String packageName;
  final String appLabel;
  final int count;

  AppStat({
    required this.packageName,
    required this.appLabel,
    required this.count,
  });
}

class AppInfo {
  final String packageName;
  final String appLabel;

  AppInfo({required this.packageName, required this.appLabel});
}
