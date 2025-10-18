import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/services/app_list_service.dart';

class AppSelectorDialog extends ConsumerStatefulWidget {
  final List<String> selectedPackages;

  const AppSelectorDialog({super.key, required this.selectedPackages});

  @override
  ConsumerState<AppSelectorDialog> createState() => _AppSelectorDialogState();
}

class _AppSelectorDialogState extends ConsumerState<AppSelectorDialog> {
  List<InstalledApp> _apps = [];
  Set<String> _selected = {};
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.selectedPackages);
    _loadApps();
  }

  Future<void> _loadApps() async {
    setState(() => _isLoading = true);
    try {
      final apps = await AppListService.getInstalledApps();
      setState(() {
        _apps = apps;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading apps: $e');
      setState(() => _isLoading = false);
    }
  }

  List<InstalledApp> get _filteredApps {
    if (_searchQuery.isEmpty) return _apps;

    final query = _searchQuery.toLowerCase();
    return _apps.where((app) {
      return app.appLabel.toLowerCase().contains(query) ||
          app.packageName.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 500,
        height: 600,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        '앱 선택',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '앱 검색...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredApps.isEmpty
                  ? Center(
                      child: Text(
                        _searchQuery.isEmpty ? '설치된 앱이 없습니다' : '검색 결과가 없습니다',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha:0.6),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredApps.length,
                      itemBuilder: (context, index) {
                        final app = _filteredApps[index];
                        final isSelected = _selected.contains(app.packageName);

                        return CheckboxListTile(
                          title: Text(app.appLabel),
                          subtitle: Text(
                            app.packageName,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          value: isSelected,
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                _selected.add(app.packageName);
                              } else {
                                _selected.remove(app.packageName);
                              }
                            });
                          },
                        );
                      },
                    ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    '${_selected.length}개 선택됨',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('취소'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context, _selected.toList());
                    },
                    child: const Text('완료'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
