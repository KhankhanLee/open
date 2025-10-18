import 'package:flutter/material.dart';

/// 사용자 정의 카테고리 모델
class CustomCategory {
  final int? id;
  final String name;
  final IconData icon;
  final Color color;
  final DateTime createdAt;
  final bool isActive;
  final List<String> packageNames; // 이 카테고리에 속한 앱들

  CustomCategory({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
    DateTime? createdAt,
    this.isActive = true,
    this.packageNames = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  CustomCategory copyWith({
    int? id,
    String? name,
    IconData? icon,
    Color? color,
    DateTime? createdAt,
    bool? isActive,
    List<String>? packageNames,
  }) {
    return CustomCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      packageNames: packageNames ?? this.packageNames,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconCodePoint': icon.codePoint,
      'colorValue': color.toARGB32,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isActive': isActive,
      'packageNames': packageNames,
    };
  }

  factory CustomCategory.fromJson(Map<String, dynamic> json) {
    return CustomCategory(
      id: json['id'] as int?,
      name: json['name'] as String,
      icon: IconData(json['iconCodePoint'] as int, fontFamily: 'MaterialIcons'),
      color: Color(json['colorValue'] as int),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      isActive: json['isActive'] as bool? ?? true,
      packageNames:
          (json['packageNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
