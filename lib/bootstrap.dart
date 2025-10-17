import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/services/notification_listener.dart';
import 'package:yeolda/core/providers.dart';

Future<ProviderContainer> bootstrap() async {
  final container = ProviderContainer();

  // 알림 리스너 시작
  _startNotificationListener(container);

  return container;
}

/// 알림 리스너를 시작하고 DB에 저장
void _startNotificationListener(ProviderContainer container) {
  final notificationService = NotificationListenerService();
  final repo = container.read(notificationRepoProvider);

  notificationService.notificationStream.listen(
    (notification) async {
      try {
        print('알림 수신: ${notification.appLabel} - ${notification.title}');
        print('내용: ${notification.text}');
        print('패키지: ${notification.packageName}');

        // DB에 저장 (분류 포함)
        final success = await repo.insertNotification(notification);

        if (success) {
          print('DB 저장 완료');
        } else {
          print('DB 저장 실패 (중복일 수 있음)');
        }
      } catch (e, stackTrace) {
        print('알림 처리 오류: $e');
        print('스택 트레이스: $stackTrace');
      }
    },
    onError: (error) {
      print('알림 스트림 오류: $error');
    },
  );

  print('알림 리스너 시작됨');
}
