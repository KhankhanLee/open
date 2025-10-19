import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/data/repo/custom_category_repo.dart';
import 'package:yeolda/data/repo/notification_repo.dart';
import 'package:yeolda/data/repo/study_repo.dart';
import 'package:yeolda/data/repo/reward_repo.dart';
import 'package:yeolda/services/classifier.dart';
import 'package:yeolda/services/notification_listener.dart';
import 'package:yeolda/services/notification_event_bus.dart';

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

final rewardRepoProvider = Provider<RewardRepo>((ref) {
  final db = ref.watch(dbProvider);
  return RewardRepo(db);
});

final customCategoryRepoProvider = Provider<CustomCategoryRepo>((ref) {
  final db = ref.watch(dbProvider);
  final eventBus = ref.watch(notificationEventBusProvider);
  return CustomCategoryRepo(db, eventBus);
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

// 알림 이벤트 버스 (싱글톤)
final notificationEventBusProvider = Provider<NotificationEventBus>((ref) {
  return NotificationEventBus();
});

// 알림 이벤트 스트림
final notificationEventStreamProvider = StreamProvider<NotificationEvent>((
  ref,
) {
  final eventBus = ref.watch(notificationEventBusProvider);
  return eventBus.stream;
});

// 사용자 잔액 스트림 Provider
final userBalanceProvider = StreamProvider((ref) async* {
  final repo = ref.watch(rewardRepoProvider);

  // 초기 잔액 조회
  yield await repo.getBalance();

  // 주기적으로 업데이트 (5초마다)
  await for (final _ in Stream.periodic(const Duration(seconds: 5))) {
    yield await repo.getBalance();
  }
});
