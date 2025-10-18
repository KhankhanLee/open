import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/data/repo/custom_category_repo.dart';
import 'package:yeolda/data/repo/notification_repo.dart';
import 'package:yeolda/data/repo/study_repo.dart';
import 'package:yeolda/services/classifier.dart';
import 'package:yeolda/services/notification_listener.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final notificationRepoProvider = Provider<NotificationRepo>((ref) {
  final db = ref.watch(dbProvider);
  final classifier = ref.watch(classifierProvider);
  return NotificationRepo(db, classifier);
});

final studyRepoProvider = Provider<StudyRepo>((ref) {
  final db = ref.watch(dbProvider);
  return StudyRepo(db);
});

final customCategoryRepoProvider = Provider<CustomCategoryRepo>((ref) {
  final db = ref.watch(dbProvider);
  return CustomCategoryRepo(db);
});

final classifierProvider = Provider<ClassifierService>((ref) {
  final customCategoryRepo = ref.watch(customCategoryRepoProvider);
  return ClassifierService(customCategoryRepo);
});

final notificationListenerProvider = Provider<NotificationListenerService>((
  ref,
) {
  return NotificationListenerService();
});
