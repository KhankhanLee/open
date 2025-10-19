import 'dart:async';
import 'package:flutter/foundation.dart';

/// 알림 이벤트 타입
enum NotificationEventType {
  newNotification, // 새 알림 수신
  updated, // 알림 업데이트 (읽음 처리 등)
  deleted, // 알림 삭제
  categoryChanged, // 커스텀 카테고리 변경 (재분류 필요)
}

/// 알림 이벤트
class NotificationEvent {
  final NotificationEventType type;
  final int? notificationId;
  final DateTime timestamp;

  NotificationEvent({
    required this.type,
    this.notificationId,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// 알림 이벤트 버스 (싱글톤)
class NotificationEventBus {
  static final NotificationEventBus _instance =
      NotificationEventBus._internal();

  factory NotificationEventBus() => _instance;

  NotificationEventBus._internal();

  final _controller = StreamController<NotificationEvent>.broadcast();

  /// 이벤트 스트림
  Stream<NotificationEvent> get stream => _controller.stream;

  /// 이벤트 발행
  void fire(NotificationEvent event) {
    debugPrint('이벤트 발행: ${event.type} (ID: ${event.notificationId})');
    _controller.add(event);
  }

  /// 새 알림 이벤트 발행
  void fireNewNotification(int notificationId) {
    fire(
      NotificationEvent(
        type: NotificationEventType.newNotification,
        notificationId: notificationId,
      ),
    );
  }

  /// 알림 업데이트 이벤트 발행
  void fireUpdate(int notificationId) {
    fire(
      NotificationEvent(
        type: NotificationEventType.updated,
        notificationId: notificationId,
      ),
    );
  }

  /// 알림 삭제 이벤트 발행
  void fireDelete(int notificationId) {
    fire(
      NotificationEvent(
        type: NotificationEventType.deleted,
        notificationId: notificationId,
      ),
    );
  }

  /// 커스텀 카테고리 변경 이벤트 발행 (기존 알림 재분류 필요)
  void fireCategoryChanged() {
    fire(NotificationEvent(type: NotificationEventType.categoryChanged));
  }

  /// 정리
  void dispose() {
    _controller.close();
  }
}
