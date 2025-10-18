import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/data/models/category.dart';
import 'package:intl/intl.dart';
import 'package:yeolda/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:yeolda/ui/widgets/category_utils.dart';

// 선택된 카테고리를 관리하는 Notifier
class SelectedCategoryNotifier extends Notifier<AppCategory> {
  @override
  AppCategory build() => AppCategory.messenger;

  void select(AppCategory category) {
    state = category;
  }
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, AppCategory>(
      SelectedCategoryNotifier.new,
    );

// 카테고리별 알림 Provider
final categoryNotificationsProvider = FutureProvider.autoDispose
    .family<List<NotificationEntry>, AppCategory>((ref, category) async {
      final repo = ref.watch(notificationRepoProvider);
      return await repo.queryTimeline(category: category, limit: 100);
    });

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final notificationsAsync = ref.watch(
      categoryNotificationsProvider(selectedCategory),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('카테고리')),
      body: Hero(
        tag: 'screen_hero',
        child: Material(
          child: Column(
            children: [
              _buildCategoryTabs(ref, selectedCategory),
              Expanded(
                child: notificationsAsync.when(
                  data: (notifications) {
                    if (notifications.isEmpty) {
                      return _buildEmptyState(selectedCategory);
                    }
                    return _buildNotificationList(notifications);
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('오류: $error')),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 1),
    );
  }

  Widget _buildCategoryTabs(WidgetRef ref, AppCategory selected) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: AppCategory.values.map((category) {
          final isSelected = category == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(CategoryUtils.getCategoryLabel(category)),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(selectedCategoryProvider.notifier).select(category);
                }
              },
              backgroundColor: CategoryUtils.getCategoryColor(
                category,
              ).withValues(alpha: 0.1),
              selectedColor: CategoryUtils.getCategoryColor(
                category,
              ).withValues(alpha: 0.3),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState(AppCategory category) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CategoryUtils.getCategoryIcon(category),
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            '${CategoryUtils.getCategoryLabel(category)} 알림이 없습니다',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationEntry> notifications) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: CategoryUtils.getCategoryColor(
                  AppCategory.values.firstWhere(
                    (c) => c.name == notification.assignedCategory,
                    orElse: () => AppCategory.other,
                  ),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                CategoryUtils.getCategoryIcon(
                  AppCategory.values.firstWhere(
                    (c) => c.name == notification.assignedCategory,
                    orElse: () => AppCategory.other,
                  ),
                ),
                color: Colors.white,
              ),
            ),
            title: Text(
              notification.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: notification.isRead
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notification.content != null &&
                    notification.content!.isNotEmpty)
                  Text(
                    notification.content!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      notification.appLabel,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const Text(' • ', style: TextStyle(fontSize: 12)),
                    Text(
                      _formatTime(notification.postedAt),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            trailing: notification.isImportant
                ? const Icon(Icons.priority_high, color: Colors.red)
                : null,
          ),
        );
      },
    );
  }

  String _formatTime(int milliseconds) {
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) {
      return '방금 전';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inDays < 1) {
      return '${diff.inHours}시간 전';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}일 전';
    } else {
      return DateFormat('MM월 dd일').format(date);
    }
  }
}
