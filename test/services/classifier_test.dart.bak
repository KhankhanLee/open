import 'package:flutter_test/flutter_test.dart';
import 'package:yeolda/data/models/category.dart';
import 'package:yeolda/services/classifier.dart';

void main() {
  late ClassifierService classifier;

  setUp(() {
    classifier = ClassifierService();
  });

  group('패키지명 기반 분류', () {
    test('카카오톡은 메신저로 분류', () {
      final result = classifier.classify(
        packageName: 'com.kakao.talk',
        title: '새 메시지',
        content: '테스트 메시지입니다',
      );

      expect(result.category, AppCategory.messenger);
    });

    test('텔레그램은 메신저로 분류', () {
      final result = classifier.classify(
        packageName: 'org.telegram.messenger',
        title: 'New message',
        content: 'Test message',
      );

      expect(result.category, AppCategory.messenger);
    });

    test('토스는 금융으로 분류', () {
      final result = classifier.classify(
        packageName: 'viva.republica.toss',
        title: '입금 알림',
        content: '10,000원이 입금되었습니다',
      );

      expect(result.category, AppCategory.finance);
    });

    test('쿠팡은 쇼핑으로 분류', () {
      final result = classifier.classify(
        packageName: 'com.coupang.mobile',
        title: '배송 출발',
        content: '상품이 배송 출발했습니다',
      );

      expect(result.category, AppCategory.shopping);
    });

    test('Duolingo는 공부로 분류', () {
      final result = classifier.classify(
        packageName: 'com.duolingo',
        title: 'Time to practice!',
        content: 'Complete your daily lesson',
      );

      expect(result.category, AppCategory.study);
    });
  });

  group('키워드 기반 분류', () {
    test('시험 키워드는 공부로 분류', () {
      final result = classifier.classify(
        packageName: 'com.example.unknown',
        title: '내일 시험 준비하세요',
        content: '모의고사 시험이 있습니다',
      );

      expect(result.category, AppCategory.study);
    });

    test('입금 키워드는 금융으로 분류', () {
      final result = classifier.classify(
        packageName: 'com.example.unknown',
        title: '입금 알림',
        content: '100,000원이 입금되었습니다',
      );

      expect(result.category, AppCategory.finance);
    });

    test('배송 키워드는 쇼핑으로 분류', () {
      final result = classifier.classify(
        packageName: 'com.example.unknown',
        title: '배송 도착',
        content: '주문하신 상품이 도착했습니다',
      );

      expect(result.category, AppCategory.shopping);
    });

    test('회의 키워드는 일정으로 분류', () {
      final result = classifier.classify(
        packageName: 'com.example.unknown',
        title: '내일 회의',
        content: '오후 3시 미팅이 있습니다',
      );

      expect(result.category, AppCategory.schedule);
    });

    test('메시지 키워드는 메신저로 분류', () {
      final result = classifier.classify(
        packageName: 'com.example.unknown',
        title: '새 메시지',
        content: '새로운 채팅 메시지가 도착했습니다',
      );

      expect(result.category, AppCategory.messenger);
    });

    test('알 수 없는 알림은 기타로 분류', () {
      final result = classifier.classify(
        packageName: 'com.example.unknown',
        title: 'Unknown',
        content: 'Unknown notification',
      );

      expect(result.category, AppCategory.other);
    });
  });

  group('중요도 판단', () {
    test('금융 카테고리는 중요로 표시', () {
      final result = classifier.classify(
        packageName: 'viva.republica.toss',
        title: '입금',
        content: '10,000원',
      );

      expect(result.category, AppCategory.finance);
      expect(result.isImportant, true);
    });

    test('긴급 키워드는 중요로 표시', () {
      final result = classifier.classify(
        packageName: 'com.example.app',
        title: '긴급 공지',
        content: '중요한 공지사항입니다',
      );

      expect(result.isImportant, true);
    });

    test('금액 패턴이 있으면 중요로 표시', () {
      final result = classifier.classify(
        packageName: 'com.example.app',
        title: '알림',
        content: '50,000원이 결제되었습니다',
      );

      expect(result.isImportant, true);
    });

    test('긴 텍스트(200자 이상)는 중요로 표시', () {
      final longContent = 'a' * 250;
      final result = classifier.classify(
        packageName: 'com.example.app',
        title: 'Long notification',
        content: longContent,
      );

      expect(result.isImportant, true);
    });

    test('시간 패턴이 있으면 중요로 표시', () {
      final result = classifier.classify(
        packageName: 'com.example.app',
        title: '일정 알림',
        content: '오후 3:30에 회의가 있습니다',
      );

      expect(result.isImportant, true);
    });

    test('일반 알림은 중요하지 않음', () {
      final result = classifier.classify(
        packageName: 'com.example.app',
        title: 'Normal notification',
        content: 'This is a normal notification',
      );

      expect(result.isImportant, false);
    });
  });

  group('복합 시나리오', () {
    test('카카오톡 + 긴급 키워드', () {
      final result = classifier.classify(
        packageName: 'com.kakao.talk',
        title: '긴급 메시지',
        content: '중요한 메시지입니다',
      );

      expect(result.category, AppCategory.messenger);
      expect(result.isImportant, true);
    });

    test('쿠팡 + 배송 + 금액', () {
      final result = classifier.classify(
        packageName: 'com.coupang.mobile',
        title: '배송 완료',
        content: '25,000원 상품이 도착했습니다',
      );

      expect(result.category, AppCategory.shopping);
      expect(result.isImportant, true);
    });

    test('알 수 없는 앱 + 시험 키워드', () {
      final result = classifier.classify(
        packageName: 'com.unknown.app',
        title: '모의고사',
        content: '내일 시험 준비하세요',
      );

      expect(result.category, AppCategory.study);
    });
  });
}
