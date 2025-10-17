import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/data/models/category.dart';
import 'package:intl/intl.dart';
import 'package:yeolda/ui/widgets/app_bottom_navigation_bar.dart';

// 타임라인 데이터를 가져오는 Provider
final timelineProvider = FutureProvider.autoDispose
    .family<List<NotificationEntry>, TimelineFilter>((ref, filter) async {
      final repo = ref.watch(notificationRepoProvider);
      return await repo.queryTimeline(
        category: filter.category,
        important: filter.importantOnly ? true : null,
        unread: filter.unreadOnly ? true : null,
        limit: 50,
      );
    });

class TimelineFilter {
  final AppCategory? category;
  final bool importantOnly;
  final bool unreadOnly;

  TimelineFilter({
    this.category,
    this.importantOnly = false,
    this.unreadOnly = false,
  });

  TimelineFilter copyWith({
    AppCategory? category,
    bool? importantOnly,
    bool? unreadOnly,
  }) {
    return TimelineFilter(
      category: category ?? this.category,
      importantOnly: importantOnly ?? this.importantOnly,
      unreadOnly: unreadOnly ?? this.unreadOnly,
    );
  }
}

class TimelinePage extends ConsumerStatefulWidget {
  const TimelinePage({super.key});

  @override
  ConsumerState<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage> {
  TimelineFilter _filter = TimelineFilter();

  @override
  Widget build(BuildContext context) {
    final timelineAsync = ref.watch(timelineProvider(_filter));

    return Scaffold(
      appBar: AppBar(
        title: const Text('열다 | Open'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: Hero(
        tag: 'screen_hero',
        child: Material(
          child: Column(
            children: [
              _buildFilterChips(),
              Expanded(
                child: timelineAsync.when(
                  data: (notifications) {
                    if (notifications.isEmpty) {
                      return _buildEmptyState();
                    }
                    return _buildTimelineList(notifications);
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text('오류: $error'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ref.invalidate(timelineProvider);
                          },
                          child: const Text('다시 시도'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChip(
              label: const Text('중요'),
              selected: _filter.importantOnly,
              onSelected: (selected) {
                setState(() {
                  _filter = _filter.copyWith(importantOnly: selected);
                });
              },
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('읽지 않음'),
              selected: _filter.unreadOnly,
              onSelected: (selected) {
                setState(() {
                  _filter = _filter.copyWith(unreadOnly: selected);
                });
              },
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('전체'),
              selected: _filter.category == null,
              onSelected: (selected) {
                setState(() {
                  _filter = TimelineFilter();
                });
              },
            ),
            const SizedBox(width: 8),
            ...AppCategory.values.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_getCategoryLabelFromEnum(category)),
                  selected: _filter.category == category,
                  onSelected: (selected) {
                    setState(() {
                      _filter = TimelineFilter(
                        category: selected ? category : null,
                      );
                    });
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            '알림이 없습니다',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            '새로운 알림이 도착하면 여기에 표시됩니다',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineList(List<NotificationEntry> notifications) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(NotificationEntry notification) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          _showNotificationDetail(notification);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // 앱 아이콘 플레이스홀더
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(notification.assignedCategory),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getCategoryIcon(notification.assignedCategory),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              notification.appLabel,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (notification.isImportant) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  '중요',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          _formatTime(notification.postedAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text(
                      _getCategoryLabel(notification.assignedCategory),
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: _getCategoryColor(
                      notification.assignedCategory,
                    ).withValues(alpha: 0.2),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                notification.title,
                style: TextStyle(
                  fontWeight: notification.isRead
                      ? FontWeight.normal
                      : FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (notification.content != null &&
                  notification.content!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  notification.content!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showNotificationDetail(NotificationEntry notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                controller: scrollController,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _getCategoryColor(
                            notification.assignedCategory,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getCategoryIcon(notification.assignedCategory),
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.appLabel,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _formatTime(notification.postedAt),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (notification.content != null &&
                      notification.content!.isNotEmpty)
                    Text(
                      notification.content!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          ref
                              .read(notificationRepoProvider)
                              .markAsRead(notification.id);
                          Navigator.pop(context);
                          ref.invalidate(timelineProvider);
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('읽음'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.pop(context);

                          // 간단한 언어 감지 (영어만)
                          final content =
                              notification.content ?? notification.title;
                          final hasEnglish = RegExp(
                            r'[a-zA-Z]',
                          ).hasMatch(content);

                          if (!hasEnglish) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('외국어 문장을 찾을 수 없습니다'),
                                ),
                              );
                            }
                            return;
                          }

                          // 학습 아이템 추가
                          try {
                            await ref
                                .read(studyRepoProvider)
                                .addStudyItem(
                                  sourceNotificationId: notification.id,
                                  lang: 'en',
                                  phrase: content,
                                  translation: '(번역 기능은 준비 중입니다)',
                                );

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('학습 아이템에 추가되었습니다'),
                                  action: SnackBarAction(
                                    label: '보기',
                                    onPressed: () {
                                      context.go('/learning');
                                    },
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text('오류: $e')));
                            }
                          }
                        },
                        icon: const Icon(Icons.school),
                        label: const Text('학습'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _getCategoryLabel(String categoryName) {
    try {
      final category = AppCategory.values.firstWhere(
        (c) => c.name == categoryName,
        orElse: () => AppCategory.other,
      );
      return _getCategoryLabelFromEnum(category);
    } catch (e) {
      return '기타';
    }
  }

  String _getCategoryLabelFromEnum(AppCategory category) {
    switch (category) {
      case AppCategory.messenger:
        return '💬 메신저';
      case AppCategory.study:
        return '📚 공부';
      case AppCategory.finance:
        return '💰 금융';
      case AppCategory.schedule:
        return '📅 일정';
      case AppCategory.shopping:
        return '🛍️ 쇼핑';
      case AppCategory.news:
        return '📰 뉴스';
      case AppCategory.other:
        return '📱 기타';
    }
  }

  Color _getCategoryColor(String categoryName) {
    try {
      final category = AppCategory.values.firstWhere(
        (c) => c.name == categoryName,
        orElse: () => AppCategory.other,
      );
      switch (category) {
        case AppCategory.messenger:
          return Colors.blue;
        case AppCategory.study:
          return Colors.purple;
        case AppCategory.finance:
          return Colors.green;
        case AppCategory.schedule:
          return Colors.orange;
        case AppCategory.shopping:
          return Colors.pink;
        case AppCategory.news:
          return Colors.red;
        case AppCategory.other:
          return Colors.grey;
      }
    } catch (e) {
      return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String categoryName) {
    try {
      final category = AppCategory.values.firstWhere(
        (c) => c.name == categoryName,
        orElse: () => AppCategory.other,
      );
      switch (category) {
        case AppCategory.messenger:
          return Icons.chat_bubble;
        case AppCategory.study:
          return Icons.school;
        case AppCategory.finance:
          return Icons.account_balance_wallet;
        case AppCategory.schedule:
          return Icons.calendar_today;
        case AppCategory.shopping:
          return Icons.shopping_bag;
        case AppCategory.news:
          return Icons.article;
        case AppCategory.other:
          return Icons.notifications;
      }
    } catch (e) {
      return Icons.notifications;
    }
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
      return DateFormat('MM월 dd일 HH:mm').format(date);
    }
  }
}
