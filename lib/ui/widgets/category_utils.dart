import 'package:flutter/material.dart';
import 'package:yeolda/data/models/category.dart';
import 'package:yeolda/data/models/custom_category.dart';

/// 카테고리 관련 유틸리티 함수들
class CategoryUtils {
  CategoryUtils._();

  /// 커스텀 카테고리 캐시 (성능 최적화)
  static final Map<String, CustomCategory> _customCategoryCache = {};

  /// 커스텀 카테고리 캐시 업데이트
  static void updateCustomCategoryCache(List<CustomCategory> categories) {
    _customCategoryCache.clear();
    for (final category in categories) {
      _customCategoryCache[category.name] = category;
    }
  }

  /// 카테고리가 커스텀 카테고리인지 확인
  static bool isCustomCategory(String categoryName) {
    // AppCategory enum에 없으면 커스텀 카테고리
    try {
      AppCategory.values.firstWhere((c) => c.name == categoryName);
      return false;
    } catch (e) {
      return true;
    }
  }

  /// 카테고리 이름(String)을 AppCategory enum으로 변환
  static AppCategory _categoryFromString(String categoryName) {
    try {
      return AppCategory.values.firstWhere(
        (c) => c.name == categoryName,
        orElse: () => AppCategory.other,
      );
    } catch (e) {
      return AppCategory.other;
    }
  }

  /// 카테고리 한글 라벨 반환 (String 버전)
  static String getCategoryLabelFromString(String categoryName) {
    // 커스텀 카테고리 확인
    if (isCustomCategory(categoryName)) {
      final customCategory = _customCategoryCache[categoryName];
      if (customCategory != null) {
        return '${String.fromCharCode(customCategory.icon.codePoint)} ${customCategory.name}';
      }
      // 캐시에 없으면 카테고리 이름만 반환
      return categoryName;
    }

    // 기본 카테고리
    final category = _categoryFromString(categoryName);
    return getCategoryLabel(category);
  }

  /// 카테고리 한글 라벨 반환
  static String getCategoryLabel(AppCategory category) {
    switch (category) {
      case AppCategory.kakaotalk:
        return '💬 카카오톡';
      case AppCategory.messenger:
        return '💬 메신저';
      case AppCategory.instagram:
        return '📷 인스타그램';
      case AppCategory.telegram:
        return '💬 텔레그램';
      case AppCategory.discord:
        return '💬 디스코드';
      case AppCategory.slack:
        return '💬 슬랙';
      case AppCategory.line:
        return '💬 LINE';
      case AppCategory.wechat:
        return '💬 WECHAT';
      case AppCategory.whatsapp:
        return '💬 WHATSAPP';
      case AppCategory.study:
        return '📚 공부';
      case AppCategory.finance:
        return '💰 금융';
      case AppCategory.schedule:
        return '📅 일정';
      case AppCategory.youtube:
        return '📺 유튜브';
      case AppCategory.shopping:
        return '🛍️ 쇼핑';
      case AppCategory.news:
        return '📰 뉴스';
      case AppCategory.other:
        return '📱 기타';
    }
  }

  /// 카테고리 색상 반환 (String 버전)
  static Color getCategoryColorFromString(String categoryName) {
    // 커스텀 카테고리 확인
    if (isCustomCategory(categoryName)) {
      final customCategory = _customCategoryCache[categoryName];
      if (customCategory != null) {
        return customCategory.color;
      }
      // 캐시에 없으면 회색 반환
      return Colors.grey;
    }

    // 기본 카테고리
    final category = _categoryFromString(categoryName);
    return getCategoryColor(category);
  }

  /// 카테고리 색상 반환
  static Color getCategoryColor(AppCategory category) {
    switch (category) {
      case AppCategory.kakaotalk:
        return Colors.blue;
      case AppCategory.messenger:
        return Colors.blue;
      case AppCategory.instagram:
        return Colors.pink;
      case AppCategory.telegram:
        return Colors.blue;
      case AppCategory.discord:
        return Colors.blue;
      case AppCategory.slack:
        return Colors.blue;
      case AppCategory.line:
        return Colors.blue;
      case AppCategory.wechat:
        return Colors.blue;
      case AppCategory.whatsapp:
        return Colors.blue;
      case AppCategory.study:
        return Colors.purple;
      case AppCategory.finance:
        return Colors.green;
      case AppCategory.schedule:
        return Colors.orange;
      case AppCategory.youtube:
        return Colors.red;
      case AppCategory.shopping:
        return Colors.pink;
      case AppCategory.news:
        return Colors.red;
      case AppCategory.other:
        return Colors.grey;
    }
  }

  /// 카테고리 아이콘 반환 (String 버전)
  static IconData getCategoryIconFromString(String categoryName) {
    // 커스텀 카테고리 확인
    if (isCustomCategory(categoryName)) {
      final customCategory = _customCategoryCache[categoryName];
      if (customCategory != null) {
        return customCategory.icon;
      }
      // 캐시에 없으면 기본 아이콘 반환
      return Icons.apps;
    }

    // 기본 카테고리
    final category = _categoryFromString(categoryName);
    return getCategoryIcon(category);
  }

  /// 카테고리 아이콘 반환
  static IconData getCategoryIcon(AppCategory category) {
    switch (category) {
      case AppCategory.kakaotalk:
        return Icons.chat_bubble;
      case AppCategory.messenger:
        return Icons.chat_bubble;
      case AppCategory.instagram:
        return Icons.photo_camera;
      case AppCategory.telegram:
        return Icons.chat_bubble;
      case AppCategory.discord:
        return Icons.chat_bubble;
      case AppCategory.slack:
        return Icons.chat_bubble;
      case AppCategory.line:
        return Icons.chat_bubble;
      case AppCategory.wechat:
        return Icons.chat_bubble;
      case AppCategory.whatsapp:
        return Icons.chat_bubble;
      case AppCategory.study:
        return Icons.school;
      case AppCategory.finance:
        return Icons.attach_money;
      case AppCategory.schedule:
        return Icons.calendar_today;
      case AppCategory.youtube:
        return Icons.videocam;
      case AppCategory.shopping:
        return Icons.shopping_bag;
      case AppCategory.news:
        return Icons.article;
      case AppCategory.other:
        return Icons.apps;
    }
  }
}
