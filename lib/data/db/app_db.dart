import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

part 'app_db.g.dart';

@DriftDatabase(include: {'app_db.drift'})
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // rewards 및 user_balance 테이블 생성
        await m.issueCustomQuery('''
              CREATE TABLE IF NOT EXISTS rewards (
                id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                type TEXT NOT NULL,
                amount INTEGER NOT NULL,
                description TEXT,
                earned_at INTEGER NOT NULL
              );
            ''');

        await m.issueCustomQuery('''
              CREATE TABLE IF NOT EXISTS user_balance (
                id INTEGER NOT NULL PRIMARY KEY DEFAULT 1,
                total_points INTEGER NOT NULL DEFAULT 0,
                used_points INTEGER NOT NULL DEFAULT 0,
                last_updated INTEGER NOT NULL
              );
            ''');
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Android에서 네이티브 라이브러리 경로 설정
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // 데이터베이스 파일이 있는 폴더 임시 경로 설정
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase(file);
  });
}
