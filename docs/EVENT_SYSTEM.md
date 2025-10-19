# 실시간 업데이트 시스템

## 🎯 개요

이 프로젝트는 **Event-Driven Architecture**를 사용하여 실시간 알림 업데이트를 구현합니다.

## 📐 아키텍처 다이어그램

```
Android 알림
    ↓
Notification Listener (Producer)
    ↓ [DB 저장 + 이벤트 발행]
Notification Event Bus (Broker)
    ↓ [Stream으로 전파]
UI Components (Consumer)
    ↓ [자동 새로고침]
사용자 화면 ✨
```

## 🔄 상세 플로우

### Producer (이벤트 생성)
- **위치**: `lib/bootstrap.dart`
- **역할**: 알림 수신 → DB 저장 → 이벤트 발행

### Broker (이벤트 중개)
- **위치**: `lib/services/notification_event_bus.dart`
- **역할**: StreamController로 이벤트 전달
- **패턴**: Pub/Sub (Publish-Subscribe)

### Consumer (이벤트 소비)
- **위치**: `lib/ui/home/timeline_page.dart`
- **역할**: 이벤트 감지 → Provider 무효화 → UI 갱신

## 💡 핵심 개념

### Kafka vs EventBus

현재 구현은 **Kafka의 경량 버전**입니다:

| Kafka (서버용) | EventBus (모바일용) |
|----------------|---------------------|
| 분산 시스템 | 단일 앱 내부 |
| 높은 복잡도 | 간단한 구조 |
| 서버 인프라 필요 | 앱 내장 |
| 대용량 처리 | 적절한 처리량 |

### 왜 이 방식을 선택했나?

1. ✅ **적절한 규모**: 모바일 앱에 적합
2. ✅ **낮은 복잡도**: 추가 인프라 불필요
3. ✅ **실시간 성능**: 즉각적인 UI 업데이트
4. ✅ **확장 가능**: 필요시 Consumer 추가 용이

## 🚀 작동 방식

### 1. 알림 발생
```dart
// Android 시스템이 알림 발생
// → NotificationListenerService가 캡처
```

### 2. 이벤트 발행 (Producer)
```dart
if (await repo.insertNotification(notification)) {
  eventBus.fire(NotificationEvent(
    type: NotificationEventType.newNotification
  ));
}
```

### 3. 이벤트 전파 (Broker)
```dart
// NotificationEventBus
final _controller = StreamController<NotificationEvent>.broadcast();

void fire(NotificationEvent event) {
  _controller.add(event); // 모든 구독자에게 전파
}
```

### 4. UI 업데이트 (Consumer)
```dart
// TimelinePage
_eventSubscription = ref.listenManual(
  notificationEventStreamProvider,
  (previous, next) {
    next.whenData((event) {
      if (event.type == NotificationEventType.newNotification) {
        ref.invalidate(timelineProvider); // 자동 새로고침!
      }
    });
  },
);
```

## 📊 이벤트 타입

```dart
enum NotificationEventType {
  newNotification,  // 새 알림 수신
  updated,          // 알림 업데이트 (읽음 처리 등)
  deleted,          // 알림 삭제
}
```

## 🔧 핵심 파일

| 파일 | 역할 | 패턴 |
|------|------|------|
| `bootstrap.dart` | Producer | 이벤트 발행 |
| `notification_event_bus.dart` | Broker | 이벤트 중개 |
| `timeline_page.dart` | Consumer | UI 갱신 |

## 🎓 더 알아보기

상세한 아키텍처 문서: [ARCHITECTURE.md](./ARCHITECTURE.md)

---

**핵심 포인트**: 
- 🎯 **단순함**: Kafka 개념을 모바일에 맞게 단순화
- ⚡ **빠름**: 네트워크 없이 즉시 전파
- 🔗 **느슨한 결합**: Producer와 Consumer가 독립적
- 🛡️ **안전함**: 메모리 누수 방지 (dispose에서 정리)
