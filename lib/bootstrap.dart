import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/services/notification_listener.dart';
import 'package:yeolda/services/notification_event_bus.dart';
import 'package:yeolda/core/providers.dart';

Future<ProviderContainer> bootstrap() async {
  final container = ProviderContainer();

  // 알림 리스너 시작
  _startNotificationListener(container);

  // 카테고리 변경 이벤트 리스너 시작
  _startCategoryChangeListener(container);

  return container;
}

/// 알림 리스너를 시작하고 DB에 저장
void _startNotificationListener(ProviderContainer container) {
  final notificationService = NotificationListenerService();
  final repo = container.read(notificationRepoProvider);
  final eventBus = container.read(notificationEventBusProvider);

  notificationService.notificationStream.listen(
    (notification) async {
      try {
        debugPrint('알림 수신: ${notification.appLabel} - ${notification.title}');
        debugPrint('내용: ${notification.text}');
        debugPrint('패키지: ${notification.packageName}');

        // DB에 저장 (분류 포함)
        final success = await repo.insertNotification(notification);

        if (success) {
          debugPrint('DB 저장 완료');
          // 새 알림 이벤트 발행 (UI 자동 갱신)
          eventBus.fire(
            NotificationEvent(type: NotificationEventType.newNotification),
          );
        } else {
          debugPrint('DB 저장 실패 (중복일 수 있음)');
        }
      } catch (e, stackTrace) {
        debugPrint('알림 처리 오류: $e');
        debugPrint('스택 트레이스: $stackTrace');
      }
    },
    onError: (error) {
      debugPrint('알림 스트림 오류: $error');
    },
  );

  debugPrint('알림 리스너 시작됨');
}

/// 카테고리 변경 이벤트를 감지하여 재분류 실행
void _startCategoryChangeListener(ProviderContainer container) {
  final eventBus = container.read(notificationEventBusProvider);
  final repo = container.read(notificationRepoProvider);

  eventBus.stream.listen((event) async {
    if (event.type == NotificationEventType.categoryChanged) {
      debugPrint('카테고리 변경 감지 - 모든 알림 재분류 시작');
      try {
        final count = await repo.reclassifyAllNotifications();
        debugPrint('재분류 완료: $count개 알림 업데이트됨');
      } catch (e, stackTrace) {
        debugPrint('재분류 오류: $e');
        debugPrint('스택 트레이스: $stackTrace');
      }
    }
  });

  debugPrint('카테고리 변경 리스너 시작됨');
}
