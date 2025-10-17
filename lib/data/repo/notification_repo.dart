import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/data/models/category.dart';
import 'package:yeolda/services/classifier.dart';
import 'package:yeolda/services/notification_listener.dart';

class NotificationRepo {
  final AppDatabase _db;
  final ClassifierService _classifier = ClassifierService();

  NotificationRepo(this._db);

  /// 수신한 알림을 분류하고 DB에 저장
  Future<bool> insertNotification(IncomingNotification incoming) async {
    // 분류
    final classification = _classifier.classify(
      packageName: incoming.packageName,
      title: incoming.title,
      content: incoming.text,
      category: incoming.category,
    );

    // 해시 생성
    final hash = incoming.generateHash();

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
              assignedCategory: classification.category.name,
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
        (posted_at / 3600000) % 24 as hour,
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

  /// 요일별 통계 (0=일요일, 6=토요일)
  Future<Map<int, int>> getStatsByWeekday() async {
    // SQLite의 strftime을 사용
    final query = '''
      SELECT 
        CAST(strftime('%w', posted_at / 1000, 'unixepoch') AS INTEGER) as weekday,
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
