import 'package:drift/drift.dart';
import 'package:flutter/material.dart' hide Table;
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/data/models/custom_category.dart' as model;

class CustomCategoryRepo {
  final AppDatabase _db;

  CustomCategoryRepo(this._db);

  /// 커스텀 카테고리 생성
  Future<int> createCategory(model.CustomCategory category) async {
    final categoryId = await _db
        .into(_db.customCategories)
        .insert(
          CustomCategoriesCompanion.insert(
            name: category.name,
            iconCodePoint: category.icon.codePoint,
            colorValue: category.color.toARGB32(),
            createdAt: category.createdAt.millisecondsSinceEpoch,
            isActive: Value(category.isActive),
          ),
        );

    // 앱 매핑 추가
    if (category.packageNames.isNotEmpty) {
      await _addAppMappings(categoryId, category.packageNames);
    }

    return categoryId;
  }

  /// 앱 매핑 추가
  Future<void> _addAppMappings(
    int categoryId,
    List<String> packageNames,
  ) async {
    for (final packageName in packageNames) {
      await _db
          .into(_db.categoryAppMappings)
          .insert(
            CategoryAppMappingsCompanion.insert(
              categoryId: categoryId,
              packageName: packageName,
              createdAt: DateTime.now().millisecondsSinceEpoch,
            ),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  /// 커스텀 카테고리 업데이트
  Future<bool> updateCategory(model.CustomCategory category) async {
    if (category.id == null) return false;

    await (_db.update(
      _db.customCategories,
    )..where((t) => t.id.equals(category.id!))).write(
      CustomCategoriesCompanion(
        name: Value(category.name),
        iconCodePoint: Value(category.icon.codePoint),
        colorValue: Value(category.color.toARGB32()),
        isActive: Value(category.isActive),
      ),
    );

    // 기존 앱 매핑 삭제 후 재추가
    await (_db.delete(
      _db.categoryAppMappings,
    )..where((t) => t.categoryId.equals(category.id!))).go();

    if (category.packageNames.isNotEmpty) {
      await _addAppMappings(category.id!, category.packageNames);
    }

    return true;
  }

  /// 커스텀 카테고리 삭제
  Future<bool> deleteCategory(int categoryId) async {
    final deleted = await (_db.delete(
      _db.customCategories,
    )..where((t) => t.id.equals(categoryId))).go();
    return deleted > 0;
  }

  /// 모든 활성 카테고리 가져오기
  Future<List<model.CustomCategory>> getActiveCategories() async {
    final categories =
        await (_db.select(_db.customCategories)
              ..where((t) => t.isActive.equals(true))
              ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
            .get();

    final result = <model.CustomCategory>[];
    for (final category in categories) {
      final mappings = await (_db.select(
        _db.categoryAppMappings,
      )..where((t) => t.categoryId.equals(category.id))).get();

      result.add(
        model.CustomCategory(
          id: category.id,
          name: category.name,
          icon: IconData(category.iconCodePoint, fontFamily: 'MaterialIcons'),
          color: Color(category.colorValue),
          createdAt: DateTime.fromMillisecondsSinceEpoch(category.createdAt),
          isActive: category.isActive,
          packageNames: mappings
              .map((m) => m.packageName)
              .toList()
              .cast<String>(),
        ),
      );
    }

    return result;
  }

  /// 특정 카테고리 가져오기
  Future<model.CustomCategory?> getCategory(int categoryId) async {
    final category = await (_db.select(
      _db.customCategories,
    )..where((t) => t.id.equals(categoryId))).getSingleOrNull();

    if (category == null) return null;

    final mappings = await (_db.select(
      _db.categoryAppMappings,
    )..where((t) => t.categoryId.equals(categoryId))).get();

    return model.CustomCategory(
      id: category.id,
      name: category.name,
      icon: IconData(category.iconCodePoint, fontFamily: 'MaterialIcons'),
      color: Color(category.colorValue),
      createdAt: DateTime.fromMillisecondsSinceEpoch(category.createdAt),
      isActive: category.isActive,
      packageNames: mappings.map((m) => m.packageName).toList().cast<String>(),
    );
  }

  /// 패키지명으로 카테고리 찾기
  Future<model.CustomCategory?> findCategoryByPackage(
    String packageName,
  ) async {
    final mapping = await (_db.select(
      _db.categoryAppMappings,
    )..where((t) => t.packageName.equals(packageName))).getSingleOrNull();

    if (mapping == null) return null;

    return getCategory(mapping.categoryId);
  }

  /// 카테고리에 앱 추가
  Future<void> addAppToCategory(int categoryId, String packageName) async {
    await _db
        .into(_db.categoryAppMappings)
        .insert(
          CategoryAppMappingsCompanion.insert(
            categoryId: categoryId,
            packageName: packageName,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  /// 카테고리에서 앱 제거
  Future<void> removeAppFromCategory(int categoryId, String packageName) async {
    await (_db.delete(_db.categoryAppMappings)
          ..where((t) => t.categoryId.equals(categoryId))
          ..where((t) => t.packageName.equals(packageName)))
        .go();
  }
}
