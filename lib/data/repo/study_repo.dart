import 'package:drift/drift.dart';
import 'package:yeolda/data/db/app_db.dart';

class StudyRepo {
  final AppDatabase _db;

  StudyRepo(this._db);

  /// 학습 아이템 추가
  Future<int> addStudyItem({
    required int sourceNotificationId,
    required String lang,
    required String phrase,
    required String translation,
  }) async {
    return await _db
        .into(_db.studyItems)
        .insert(
          StudyItemsCompanion.insert(
            sourceNotificationId: sourceNotificationId,
            lang: lang,
            phrase: phrase,
            translation: translation,
            reviewLevel: const Value(0),
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
  }

  /// 모든 학습 아이템 조회
  Future<List<StudyItem>> getAllItems({String? lang}) async {
    final query = _db.select(_db.studyItems)
      ..orderBy([
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);

    if (lang != null) {
      query.where((t) => t.lang.equals(lang));
    }

    return await query.get();
  }

  /// 복습이 필요한 아이템 조회 (reviewLevel이 낮은 순)
  Future<List<StudyItem>> getItemsForReview({
    String? lang,
    int limit = 20,
  }) async {
    final query = _db.select(_db.studyItems)
      ..orderBy([
        (t) => OrderingTerm(expression: t.reviewLevel, mode: OrderingMode.asc),
        (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ])
      ..limit(limit);

    if (lang != null) {
      query.where((t) => t.lang.equals(lang));
    }

    return await query.get();
  }

  /// 복습 레벨 업데이트
  Future<void> updateReviewLevel(int id, int newLevel) async {
    await (_db.update(_db.studyItems)..where((t) => t.id.equals(id))).write(
      StudyItemsCompanion(reviewLevel: Value(newLevel)),
    );
  }

  /// 학습 아이템 삭제
  Future<void> deleteItem(int id) async {
    await (_db.delete(_db.studyItems)..where((t) => t.id.equals(id))).go();
  }

  /// 언어별 통계
  Future<Map<String, int>> getStatsByLanguage() async {
    final query = '''
      SELECT lang, COUNT(*) as count
      FROM study_items
      GROUP BY lang
      ORDER BY count DESC
    ''';

    final result = await _db
        .customSelect(query, readsFrom: {_db.studyItems})
        .get();

    final stats = <String, int>{};
    for (final row in result) {
      final lang = row.read<String>('lang');
      final count = row.read<int>('count');
      stats[lang] = count;
    }

    return stats;
  }

  /// 총 학습 아이템 수
  Future<int> getTotalCount() async {
    final query = _db.selectOnly(_db.studyItems)
      ..addColumns([_db.studyItems.id.count()]);

    final result = await query.getSingle();
    return result.read(_db.studyItems.id.count()) ?? 0;
  }
}
