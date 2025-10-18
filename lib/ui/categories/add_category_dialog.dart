import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/data/models/custom_category.dart';
import 'package:yeolda/ui/categories/app_selector_dialog.dart';

class AddCategoryDialog extends ConsumerStatefulWidget {
  final CustomCategory? category;

  const AddCategoryDialog({super.key, this.category});

  @override
  ConsumerState<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends ConsumerState<AddCategoryDialog> {
  late final TextEditingController _nameController;
  late Color _selectedColor;
  late IconData _selectedIcon;
  List<String> _selectedPackages = [];

  final List<Color> _colorOptions = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
  ];

  final List<IconData> _iconOptions = [
    Icons.work,
    Icons.school,
    Icons.favorite,
    Icons.home,
    Icons.sports_esports,
    Icons.music_note,
    Icons.movie,
    Icons.restaurant,
    Icons.local_cafe,
    Icons.flight,
    Icons.directions_car,
    Icons.fitness_center,
    Icons.attach_money,
    Icons.shopping_bag,
    Icons.camera_alt,
    Icons.pets,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? '');
    _selectedColor = widget.category?.color ?? Colors.blue;
    _selectedIcon = widget.category?.icon ?? Icons.category;
    _selectedPackages = List.from(widget.category?.packageNames ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _selectApps() async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (context) =>
          AppSelectorDialog(selectedPackages: _selectedPackages),
    );

    if (result != null) {
      setState(() {
        _selectedPackages = result;
      });
    }
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('카테고리 이름을 입력하세요')));
      return;
    }

    final repo = ref.read(customCategoryRepoProvider);
    final category = CustomCategory(
      id: widget.category?.id,
      name: _nameController.text.trim(),
      icon: _selectedIcon,
      color: _selectedColor,
      createdAt: widget.category?.createdAt ?? DateTime.now(),
      isActive: true,
      packageNames: _selectedPackages,
    );

    try {
      if (widget.category == null) {
        await repo.createCategory(category);
      } else {
        await repo.updateCategory(category);
      }
      if (mounted) Navigator.pop(context, category);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('저장 실패: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.category == null ? '카테고리 추가' : '카테고리 수정'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '카테고리 이름',
                hintText: '예: 업무, 취미, 쇼핑',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 24),
            Text('색상', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _colorOptions.map((color) {
                final isSelected = color == _selectedColor;
                return InkWell(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 3)
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text('아이콘', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _iconOptions.map((icon) {
                final isSelected = icon == _selectedIcon;
                return InkWell(
                  onTap: () => setState(() => _selectedIcon = icon),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _selectedColor.withOpacity(0.2)
                          : Colors.grey[200],
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: _selectedColor, width: 2)
                          : null,
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? _selectedColor : Colors.grey[600],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text('연결된 앱', style: Theme.of(context).textTheme.titleSmall),
                const Spacer(),
                TextButton.icon(
                  onPressed: _selectApps,
                  icon: const Icon(Icons.add),
                  label: const Text('앱 선택'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_selectedPackages.isEmpty)
              Text(
                '선택된 앱이 없습니다',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.5),
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selectedPackages.map((pkg) {
                  return Chip(
                    label: Text(
                      pkg.split('.').last,
                      style: const TextStyle(fontSize: 12),
                    ),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () {
                      setState(() {
                        _selectedPackages.remove(pkg);
                      });
                    },
                  );
                }).toList(),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        FilledButton(onPressed: _save, child: const Text('저장')),
      ],
    );
  }
}
