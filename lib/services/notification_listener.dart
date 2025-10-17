import 'dart:async';
import 'package:flutter/services.dart';

class NotificationListenerService {
  static const String _channelName = 'yeolda/notifications';
  static const EventChannel _eventChannel = EventChannel(_channelName);

  Stream<IncomingNotification>? _notificationStream;

  /// 알림 스트림을 반환합니다
  Stream<IncomingNotification> get notificationStream {
    _notificationStream ??= _eventChannel.receiveBroadcastStream().map((
      dynamic event,
    ) {
      try {
        final data = event as Map<dynamic, dynamic>;
        return IncomingNotification.fromMap(Map<String, dynamic>.from(data));
      } catch (e) {
        print('Error parsing notification: $e');
        rethrow;
      }
    });

    return _notificationStream!;
  }

  /// 알림 접근 권한이 허용되었는지 확인
  static Future<bool> checkPermission() async {
    try {
      const platform = MethodChannel('yeolda/permissions');
      final bool hasPermission = await platform.invokeMethod(
        'checkNotificationPermission',
      );
      return hasPermission;
    } catch (e) {
      print('Error checking notification permission: $e');
      return false;
    }
  }

  /// 알림 접근 설정 화면으로 이동
  static Future<void> openSettings() async {
    try {
      const platform = MethodChannel('yeolda/permissions');
      await platform.invokeMethod('openNotificationSettings');
    } catch (e) {
      print('Error opening notification settings: $e');
    }
  }
}

class IncomingNotification {
  final String packageName;
  final String appLabel;
  final String title;
  final String text;
  final String? category;
  final String? channelId;
  final int postedAt;

  IncomingNotification({
    required this.packageName,
    required this.appLabel,
    required this.title,
    required this.text,
    this.category,
    this.channelId,
    required this.postedAt,
  });

  factory IncomingNotification.fromMap(Map<String, dynamic> map) {
    return IncomingNotification(
      packageName: map['package'] as String,
      appLabel: map['appLabel'] as String,
      title: map['title'] as String,
      text: map['text'] as String? ?? '',
      category: map['category'] as String?,
      channelId: map['channelId'] as String?,
      postedAt: map['postedAt'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'package': packageName,
      'appLabel': appLabel,
      'title': title,
      'text': text,
      'category': category,
      'channelId': channelId,
      'postedAt': postedAt,
    };
  }

  /// 중복 방지용 해시 생성
  String generateHash() {
    final content = '$title$text$postedAt';
    return content.hashCode.toString();
  }
}
