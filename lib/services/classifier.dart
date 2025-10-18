import 'package:yeolda/data/models/category.dart';
import 'package:yeolda/data/models/custom_category.dart';
import 'package:yeolda/data/repo/custom_category_repo.dart';

class ClassifierService {
  final CustomCategoryRepo _customCategoryRepo;

  ClassifierService(this._customCategoryRepo);

  /// 알림을 분류하고 중요도를 판단합니다
  Future<ClassificationResult> classify({
    required String packageName,
    required String title,
    required String content,
    String? category,
  }) async {
    final lowerTitle = title.toLowerCase();
    final lowerContent = content.toLowerCase();
    final combinedText = '$lowerTitle $lowerContent';

    // 0차: 커스텀 카테고리 확인 (최우선)
    final customCategory = await _customCategoryRepo.findCategoryByPackage(
      packageName,
    );
    AppCategory? assignedCategory;

    if (customCategory != null) {
      // 커스텀 카테고리는 'other' 타입으로 분류
      assignedCategory = AppCategory.other;
    } else {
      // 1차: 패키지명 기반 분류
      assignedCategory = _classifyByPackage(packageName);

      // 2차: 키워드 기반 분류 (패키지 분류가 없을 경우)
      assignedCategory ??= _classifyByKeyword(combinedText);
    }

    // 3차: 중요도 판단
    final isImportant = _determineImportance(
      combinedText,
      assignedCategory,
      content.length,
    );

    return ClassificationResult(
      category: assignedCategory,
      isImportant: isImportant,
      customCategory: customCategory,
    );
  }

  AppCategory? _classifyByPackage(String packageName) {
    final lower = packageName.toLowerCase();
    // KakaoTalk
    if (lower.contains('kakaotalk')) {
      return AppCategory.kakaotalk;
    }
    // Instagram
    if (lower.contains('instagram')) {
      return AppCategory.instagram;
    }
    // Telegram
    if (lower.contains('telegram')) {
      return AppCategory.telegram;
    }
    // Discord
    if (lower.contains('discord')) {
      return AppCategory.discord;
    }
    // Slack
    if (lower.contains('slack')) {
      return AppCategory.slack;
    }
    // Line
    if (lower.contains('line')) {
      return AppCategory.line;
    }
    // Wechat 
    if (lower.contains('wechat')) {
      return AppCategory.wechat;
    }
    // Whatsapp
    if (lower.contains('whatsapp')) {
      return AppCategory.whatsapp;
    }
    // Messenger
    if (lower.contains('messenger')) {
      return AppCategory.messenger;
    }

    // Study
    if (lower.contains('duolingo') ||
        lower.contains('memorion') ||
        lower.contains('coursera') ||
        lower.contains('udemy') ||
        lower.contains('notion') ||
        lower.contains('evernote') ||
        lower.contains('classroom')) {
      return AppCategory.study;
    }

    // Finance
    if (lower.contains('toss') ||
        lower.contains('kakaobank') ||
        lower.contains('shinhan') ||
        lower.contains('kbank') ||
        lower.contains('hana') ||
        lower.contains('woori') ||
        lower.contains('nh') ||
        lower.contains('payco') ||
        lower.contains('kakaopay')) {
      return AppCategory.finance;
    }

    // Schedule
    if (lower.contains('calendar') ||
        lower.contains('reminder') ||
        lower.contains('todo') ||
        lower.contains('alarm') ||
        lower.contains('clock')) {
      return AppCategory.schedule;
    }

    // Shopping
    if (lower.contains('coupang') ||
        lower.contains('gmarket') ||
        lower.contains('11st') ||
        lower.contains('naver') && lower.contains('shopping') ||
        lower.contains('auction') ||
        lower.contains('kurly') ||
        lower.contains('musinsa')) {
      return AppCategory.shopping;
    }

    // News
    if (lower.contains('news') ||
        lower.contains('naver') && !lower.contains('shopping') ||
        lower.contains('daum')) {
      return AppCategory.news;
    }

    return null;
  }

  AppCategory _classifyByKeyword(String text) {
    // Study keywords (한글/영문)
    final studyKeywords = [
      '시험',
      '모의고사',
      '퀴즈',
      '과제',
      '강의',
      '스터디',
      '공부',
      '수업',
      '학습',
      'exam',
      'quiz',
      'assignment',
      'homework',
      'class',
      'lecture',
      'study',
    ];

    // Finance keywords
    final financeKeywords = [
      '입금',
      '출금',
      '결제',
      '송금',
      '이체',
      '카드',
      '계좌',
      '잔액',
      '원',
      'deposit',
      'withdraw',
      'payment',
      'transfer',
      'balance',
    ];

    // Schedule keywords
    final scheduleKeywords = [
      '일정',
      '미팅',
      '회의',
      '약속',
      '예정',
      '알림',
      'meeting',
      'appointment',
      'schedule',
      'reminder',
      'event',
    ];

    // Shopping keywords
    final shoppingKeywords = [
      '배송',
      '도착',
      '주문',
      '발송',
      '택배',
      '출고',
      'delivery',
      'shipped',
      'order',
      'package',
    ];

    // Messenger keywords
    final messengerKeywords = ['메시지', '채팅', '답장', 'message', 'chat', 'replied'];

    // 각 카테고리별 매칭 점수 계산
    final scores = <AppCategory, int>{};

    for (final keyword in studyKeywords) {
      if (text.contains(keyword)) {
        scores[AppCategory.study] = (scores[AppCategory.study] ?? 0) + 1;
      }
    }

    for (final keyword in financeKeywords) {
      if (text.contains(keyword)) {
        scores[AppCategory.finance] = (scores[AppCategory.finance] ?? 0) + 1;
      }
    }

    for (final keyword in scheduleKeywords) {
      if (text.contains(keyword)) {
        scores[AppCategory.schedule] = (scores[AppCategory.schedule] ?? 0) + 1;
      }
    }

    for (final keyword in shoppingKeywords) {
      if (text.contains(keyword)) {
        scores[AppCategory.shopping] = (scores[AppCategory.shopping] ?? 0) + 1;
      }
    }

    for (final keyword in messengerKeywords) {
      if (text.contains(keyword)) {
        scores[AppCategory.messenger] =
            (scores[AppCategory.messenger] ?? 0) + 1;
      }
    }

    // 가장 높은 점수의 카테고리 반환
    if (scores.isEmpty) {
      return AppCategory.other;
    }

    var maxScore = 0;
    var maxCategory = AppCategory.other;

    scores.forEach((category, score) {
      if (score > maxScore) {
        maxScore = score;
        maxCategory = category;
      }
    });

    return maxCategory;
  }

  bool _determineImportance(
    String text,
    AppCategory category,
    int contentLength,
  ) {
    // 긴 텍스트는 중요할 가능성이 높음
    if (contentLength > 200) {
      return true;
    }

    // 금융 카테고리는 기본적으로 중요
    if (category == AppCategory.finance) {
      return true;
    }

    // 중요 키워드 체크
    final importantKeywords = [
      '긴급',
      '중요',
      '필수',
      '마감',
      '오늘',
      '내일',
      'urgent',
      'important',
      'deadline',
      'today',
      'tomorrow',
    ];

    for (final keyword in importantKeywords) {
      if (text.contains(keyword)) {
        return true;
      }
    }

    // 금액 패턴 (숫자 + 원)
    if (RegExp(r'\d{1,3}(,\d{3})*원').hasMatch(text)) {
      return true;
    }

    // 날짜/시간 패턴
    if (RegExp(r'\d{1,2}:\d{2}').hasMatch(text) ||
        RegExp(r'\d{1,2}월 \d{1,2}일').hasMatch(text)) {
      return true;
    }

    return false;
  }
}

class ClassificationResult {
  final AppCategory category;
  final bool isImportant;
  final CustomCategory? customCategory;

  ClassificationResult({
    required this.category,
    required this.isImportant,
    this.customCategory,
  });
}
