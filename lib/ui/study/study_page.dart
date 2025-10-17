import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';

// 학습 아이템 Provider
final studyItemsProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(studyRepoProvider);
  return await repo.getAllItems();
});

class StudyPage extends ConsumerWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studyItemsAsync = ref.watch(studyItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('학습'),
        actions: [
          IconButton(
            icon: const Icon(Icons.quiz),
            onPressed: () {
              // TODO: 퀴즈 시작
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('퀴즈 기능은 준비 중입니다')));
            },
          ),
        ],
      ),
      body: Hero(
        tag: 'screen_hero',
        child: Material(
          child: studyItemsAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return _buildEmptyState(context);
              }
              return _buildStudyList(context, items);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('오류: $error')),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 3),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('알림에서 외국어 문장을 선택하면 학습 아이템으로 추가됩니다')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('학습 추가'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            '학습 아이템이 없습니다',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            '알림에서 외국어 문장을 선택해\n학습 자료로 추가하세요',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.go('/home');
            },
            icon: const Icon(Icons.timeline),
            label: const Text('타임라인으로 이동'),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyList(BuildContext context, List<StudyItem> items) {
    // 언어별 그룹화
    final Map<String, List<StudyItem>> groupedItems = {};
    for (final item in items) {
      groupedItems.putIfAbsent(item.lang, () => []).add(item);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildStatsSummary(items),
        const SizedBox(height: 24),
        ...groupedItems.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Text(
                      _getLanguageFlag(entry.key),
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _getLanguageName(entry.key),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('${entry.value.length}개'),
                      backgroundColor: Colors.blue.shade100,
                    ),
                  ],
                ),
              ),
              ...entry.value.map((item) => _buildStudyCard(context, item)),
              const SizedBox(height: 16),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildStatsSummary(List<StudyItem> items) {
    final totalItems = items.length;
    final avgReviewLevel = items.isEmpty
        ? 0.0
        : items.map((e) => e.reviewLevel).reduce((a, b) => a + b) /
              items.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Icon(Icons.book, size: 32, color: Colors.blue),
                const SizedBox(height: 8),
                Text(
                  '$totalItems',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('학습 아이템'),
              ],
            ),
            Column(
              children: [
                const Icon(Icons.trending_up, size: 32, color: Colors.green),
                const SizedBox(height: 8),
                Text(
                  avgReviewLevel.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('평균 레벨'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudyCard(BuildContext context, StudyItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.phrase,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildReviewLevelBadge(item.reviewLevel),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.translation,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('복습 기능은 준비 중입니다')),
                    );
                  },
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('복습'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    _showDeleteDialog(context, item);
                  },
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text('삭제'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewLevelBadge(int level) {
    Color color;
    String label;

    if (level == 0) {
      color = Colors.grey;
      label = '새로움';
    } else if (level < 3) {
      color = Colors.orange;
      label = 'Lv.$level';
    } else if (level < 5) {
      color = Colors.blue;
      label = 'Lv.$level';
    } else {
      color = Colors.green;
      label = 'Lv.$level';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, StudyItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('학습 아이템 삭제'),
        content: Text('${item.phrase}을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // TODO: 삭제 구현
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('삭제되었습니다')));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  String _getLanguageFlag(String lang) {
    switch (lang.toLowerCase()) {
      case 'en':
        return '🇺🇸';
      case 'ja':
        return '🇯🇵';
      case 'zh':
        return '🇨🇳';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      case 'de':
        return '🇩🇪';
      default:
        return '🌐';
    }
  }

  String _getLanguageName(String lang) {
    switch (lang.toLowerCase()) {
      case 'en':
        return '영어';
      case 'ja':
        return '일본어';
      case 'zh':
        return '중국어';
      case 'es':
        return '스페인어';
      case 'fr':
        return '프랑스어';
      case 'de':
        return '독일어';
      default:
        return '기타';
    }
  }
}
