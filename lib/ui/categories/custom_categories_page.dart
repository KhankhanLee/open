import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/data/models/custom_category.dart';
import 'package:yeolda/ui/categories/add_category_dialog.dart';

class CustomCategoriesPage extends ConsumerStatefulWidget {
  const CustomCategoriesPage({super.key});

  @override
  ConsumerState<CustomCategoriesPage> createState() =>
      _CustomCategoriesPageState();
}

class _CustomCategoriesPageState extends ConsumerState<CustomCategoriesPage> {
  List<CustomCategory> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(customCategoryRepoProvider);
      final categories = await repo.getActiveCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading categories: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteCategory(CustomCategory category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('카테고리 삭제'),
        content: Text('"${category.name}" 카테고리를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true && category.id != null) {
      final repo = ref.read(customCategoryRepoProvider);
      await repo.deleteCategory(category.id!);
      await _loadCategories();
    }
  }

  Future<void> _editCategory(CustomCategory category) async {
    final result = await showDialog<CustomCategory>(
      context: context,
      builder: (context) => AddCategoryDialog(category: category),
    );

    if (result != null) {
      await _loadCategories();
    }
  }

  Future<void> _addCategory() async {
    final result = await showDialog<CustomCategory>(
      context: context,
      builder: (context) => const AddCategoryDialog(),
    );

    if (result != null) {
      await _loadCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('커스텀 카테고리')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _categories.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 80,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '등록된 커스텀 카테고리가 없습니다',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '아래 버튼을 눌러 새 카테고리를 추가하세요',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: category.color.withOpacity(0.2),
                      child: Icon(category.icon, color: category.color),
                    ),
                    title: Text(
                      category.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      category.packageNames.isEmpty
                          ? '연결된 앱 없음'
                          : '${category.packageNames.length}개 앱 연결됨',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () => _editCategory(category),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red,
                          onPressed: () => _deleteCategory(category),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCategory,
        icon: const Icon(Icons.add),
        label: const Text('카테고리 추가'),
      ),
    );
  }
}
