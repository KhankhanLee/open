# 열다 (Yeolda) - 아키텍처 문서

## 📐 전체 시스템 아키텍처

```
┌─────────────────────────────────────────────────────────────────┐
│                         Android 시스템                            │
│                    (알림 발생: 카카오톡, 유튜브 등)                 │
└────────────────────────────┬────────────────────────────────────┘
                             │ Android Notification
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                   NotificationListenerService                    │
│                     (Android Native Bridge)                      │
│                    EventChannel로 Flutter에 전달                  │
└────────────────────────────┬────────────────────────────────────┘
                             │ Stream<IncomingNotification>
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Flutter Application                         │
│                         (bootstrap.dart)                         │
└─────────────────────────────────────────────────────────────────┘
                             │
                   ┌─────────┴─────────┐
                   ▼                   ▼
          ┌─────────────┐     ┌──────────────┐
          │ Classifier  │     │   Database   │
          │  (분류)      │     │  (저장)       │
          └──────┬──────┘     └──────┬───────┘
                 │                   │
                 └─────────┬─────────┘
                           ▼
                 ┌──────────────────┐
                 │ NotificationRepo │
                 │  insertNotification()
                 └─────────┬────────┘
                           │ success?
                           ▼
                 ┌──────────────────┐
                 │ EventBus.fire()  │ ◄─── Producer
                 │ (이벤트 발행)      │
                 └─────────┬────────┘
                           │
                           │ NotificationEvent
                           ▼
                 ┌──────────────────┐
                 │ NotificationEventBus  │ ◄─── Broker
                 │ (Stream Controller)   │
                 └─────────┬─────────────┘
                           │ Stream
                   ┌───────┴───────┐
                   ▼               ▼
          ┌─────────────┐  ┌─────────────┐
          │ TimelinePage│  │  StatsPage  │ ◄─── Consumers
          │ (자동 갱신)  │  │  (필요시)    │
          └─────────────┘  └─────────────┘
```

---

## 🔄 실시간 업데이트 플로우 (Event-Driven Architecture)

### 1️⃣ 알림 수신 단계
```
Android Notification
  ↓
NotificationListenerService (Native)
  ↓
EventChannel
  ↓
NotificationListenerService.notificationStream (Dart)
```

### 2️⃣ 처리 및 저장 단계
```
IncomingNotification
  ↓
ClassifierService.classify() → CustomCategoryRepo 조회
  ↓                              ↓
  ↓                         커스텀 카테고리 확인
  ↓                              ↓
AppCategory 결정 ← ─────────────┘
  ↓
NotificationRepo.insertNotification()
  ↓
Database (SQLite via Drift)
```

### 3️⃣ 이벤트 발행 단계 (Producer)
```
insertNotification() 성공
  ↓
NotificationEventBus.fire()
  ↓
NotificationEvent(type: newNotification)
  ↓
StreamController.add()
```

### 4️⃣ UI 업데이트 단계 (Consumer)
```
NotificationEventBus.stream
  ↓
TimelinePage.listenManual()
  ↓
event.type == newNotification?
  ↓ Yes
ref.invalidate(timelineProvider)
  ↓
타임라인 자동 새로고침 ✨
```

---

## 📦 주요 컴포넌트

### Producer (이벤트 생성자)
- **bootstrap.dart**: `_startNotificationListener()`
- **역할**: DB 저장 성공 시 이벤트 발행
- **코드**:
  ```dart
  if (success) {
    eventBus.fire(NotificationEvent(
      type: NotificationEventType.newNotification
    ));
  }
  ```

### Broker (메시지 중개자)
- **notification_event_bus.dart**: `NotificationEventBus`
- **역할**: StreamController로 이벤트 중개
- **패턴**: Singleton + Broadcast Stream
- **코드**:
  ```dart
  final _controller = StreamController<NotificationEvent>.broadcast();
  Stream<NotificationEvent> get stream => _controller.stream;
  void fire(NotificationEvent event) => _controller.add(event);
  ```

### Consumer (이벤트 소비자)
- **timeline_page.dart**: `_TimelinePageState`
- **역할**: 이벤트 감지 → UI 갱신
- **코드**:
  ```dart
  _eventSubscription = ref.listenManual(
    notificationEventStreamProvider,
    (previous, next) {
      next.whenData((event) {
        if (event.type == NotificationEventType.newNotification) {
          ref.invalidate(timelineProvider);
        }
      });
    },
  );
  ```

---

## 🎯 설계 원칙

### 1. **Pub/Sub 패턴**
- Producer와 Consumer가 직접 연결되지 않음
- EventBus가 중개하여 느슨한 결합 (Loose Coupling)

### 2. **Single Responsibility**
- NotificationListener: 알림 수신만
- Classifier: 분류만
- EventBus: 이벤트 전달만
- UI: 표시만

### 3. **Reactive Programming**
- Stream 기반 이벤트 처리
- Riverpod Provider로 상태 관리

### 4. **메모리 안전성**
- `listenManual` 사용: initState에서 구독
- `ProviderSubscription`: dispose에서 정리
- `mounted` 체크: 위젯 생명주기 고려

---

## 🔑 핵심 기술

| 계층 | 기술 | 역할 |
|------|------|------|
| Native | Android NotificationListenerService | 시스템 알림 수신 |
| Bridge | Flutter MethodChannel/EventChannel | Native ↔ Dart 통신 |
| Stream | Dart Stream | 비동기 이벤트 처리 |
| State | Riverpod | 상태 관리 + Provider |
| Database | Drift (SQLite) | 로컬 데이터 저장 |
| Event Bus | StreamController | 앱 내 메시징 |

---

## 📊 데이터 플로우

```
┌──────────────────────────────────────────────────────────────┐
│                      데이터 라이프사이클                        │
└──────────────────────────────────────────────────────────────┘

1. Android Notification
   ↓ (Native)
2. EventChannel Stream
   ↓ (Platform Channel)
3. IncomingNotification Model
   ↓ (Dart Object)
4. ClassifierService
   ↓ (분류 로직)
5. ClassificationResult
   ↓ (category + customCategory)
6. Database (NotificationEntry)
   ↓ (영구 저장)
7. NotificationEvent
   ↓ (이벤트 발행)
8. EventBus Stream
   ↓ (실시간 전파)
9. UI Provider Invalidation
   ↓ (상태 갱신)
10. Widget Rebuild
    ↓ (화면 업데이트)
11. User Interface ✨
```

---

## 🚀 성능 최적화

### 1. **autoDispose**
```dart
final timelineProvider = FutureProvider.autoDispose.family(...)
```
- 화면을 벗어나면 자동으로 리소스 해제

### 2. **Broadcast Stream**
```dart
StreamController<NotificationEvent>.broadcast()
```
- 여러 Consumer가 동시에 구독 가능

### 3. **Debounce/Throttle**
- 빠른 연속 이벤트 처리 시 고려 사항
- 현재는 DB 저장 성공 시에만 발행하므로 불필요

### 4. **Caching**
```dart
CategoryUtils.updateCustomCategoryCache(categories)
```
- 커스텀 카테고리를 메모리에 캐시하여 DB 조회 최소화

---

## 🔍 디버깅 가이드

### 이벤트가 발행되지 않는 경우
1. **로그 확인**:
   ```
   알림 수신: ...
   DB 저장 완료
   🔔 이벤트 발행: newNotification
   ```

2. **원인**:
   - DB 저장 실패 (중복 알림)
   - EventBus가 초기화되지 않음

### UI가 업데이트되지 않는 경우
1. **로그 확인**:
   ```
   🔄 새 알림 감지 - 타임라인 자동 새로고침
   ```

2. **원인**:
   - Consumer가 구독하지 않음
   - 위젯이 dispose됨 (mounted 체크)
   - Provider가 invalidate되지 않음

---

## 📝 추가 개선 가능 사항

### 1. **이벤트 타입 확장**
```dart
enum NotificationEventType {
  newNotification,  // 새 알림
  updated,          // 읽음 처리
  deleted,          // 삭제
  categoryChanged,  // 카테고리 변경
}
```

### 2. **여러 Consumer 추가**
- StatsPage: 통계 자동 갱신
- CategoriesPage: 카테고리별 알림 수 갱신
- Badge: 읽지 않은 알림 수 표시

### 3. **에러 처리 강화**
```dart
eventBus.stream.handleError((error) {
  // 에러 로깅 및 복구
});
```

### 4. **이벤트 히스토리**
```dart
List<NotificationEvent> _eventHistory = [];
```
- 디버깅용 이벤트 기록

---

## 🎓 학습 자료

### Kafka vs EventBus 비교

| 특징 | Kafka (서버용) | EventBus (모바일용) |
|------|----------------|---------------------|
| 규모 | 분산 시스템 | 단일 앱 |
| 복잡도 | 높음 | 낮음 |
| 인프라 | 서버 필요 | 앱 내장 |
| 지속성 | 디스크 저장 | 메모리 (선택적) |
| 처리량 | 매우 높음 | 충분함 |
| 지연시간 | 네트워크 의존 | 즉시 |

---

## 📚 참고 문서

- [Flutter EventChannel](https://api.flutter.dev/flutter/services/EventChannel-class.html)
- [Riverpod listenManual](https://riverpod.dev/docs/concepts/reading#listenmanual)
- [Dart Streams](https://dart.dev/tutorials/language/streams)
- [Pub/Sub Pattern](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern)

---

**작성일**: 2025-10-19  
**버전**: 1.0.0  
**작성자**: AI Assistant
