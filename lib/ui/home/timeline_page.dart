import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/data/db/app_db.dart';
import 'package:yeolda/data/models/category.dart';
import 'package:intl/intl.dart';
import 'package:yeolda/services/notification_listener.dart';
import 'package:yeolda/services/notification_event_bus.dart';
import 'package:yeolda/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:yeolda/ui/widgets/category_utils.dart';
import 'package:yeolda/ui/widgets/responsive_layout.dart';

// 타임라인 데이터를 가져오는 Provider
final timelineProvider = FutureProvider.autoDispose
    .family<List<NotificationEntry>, TimelineFilter>((ref, filter) async {
      final repo = ref.watch(notificationRepoProvider);
      return await repo.queryTimeline(
        category: filter.category,
        important: filter.importantOnly ? true : null,
        unread: filter.unreadOnly ? true : null,
        limit: 500,
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
  ProviderSubscription<AsyncValue<NotificationEvent>>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    // 커스텀 카테고리 캐시 로드
    _loadCustomCategories();
    // 알림 이벤트 리스닝 시작
    _startListeningToEvents();
  }

  @override
  void dispose() {
    // 구독 취소
    _eventSubscription?.close();
    super.dispose();
  }

  Future<void> _loadCustomCategories() async {
    final repo = ref.read(customCategoryRepoProvider);
    final categories = await repo.getActiveCategories();
    CategoryUtils.updateCustomCategoryCache(categories);
  }

  /// 알림 이벤트를 감지하여 자동 새로고침 (initState에서 안전하게 실행)
  void _startListeningToEvents() {
    _eventSubscription = ref.listenManual(notificationEventStreamProvider, (
      previous,
      next,
    ) {
      next.whenData((event) {
        if (event.type == NotificationEventType.newNotification) {
          debugPrint('새 알림 감지 - 타임라인 자동 새로고침');
          if (mounted) {
            ref.invalidate(timelineProvider);
          }
        } else if (event.type == NotificationEventType.categoryChanged) {
          debugPrint('커스텀 카테고리 변경 감지 - 캐시 갱신 및 타임라인 새로고침');
          if (mounted) {
            _loadCustomCategories();
            ref.invalidate(timelineProvider);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final timelineAsync = ref.watch(timelineProvider(_filter));

    return Scaffold(
      appBar: AppBar(
        title: const Text('열다 | Open'),
        actions: [
          // 새로고침 버튼
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(timelineProvider);
            },
            tooltip: '새로고침',
          ),
          // 전체 알림 수 표시 (디버그)
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showDebugInfo,
          ),
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
      padding: ResponsiveLayout.horizontalPadding(
        context,
      ).add(ResponsiveLayout.verticalPadding(context)),
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
                  label: Text(CategoryUtils.getCategoryLabel(category)),
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
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addTestNotification,
            icon: const Icon(Icons.add),
            label: const Text('테스트 알림 추가'),
          ),
        ],
      ),
    );
  }

  /// 테스트 알림 추가 (디버그용)
  Future<void> _addTestNotification() async {
    final repo = ref.read(notificationRepoProvider);
    final now = DateTime.now().millisecondsSinceEpoch;

    // 테스트 알림들을 추가
    final testNotifications = [
      {
        'packageName': 'com.kakao.talk',
        'appLabel': '카카오톡',
        'title': '홍길동',
        'text': '안녕하세요! 잘 지내시나요?',
      },
      {
        'packageName': 'com.example.doit',
        'appLabel': 'Do It',
        'title': '할 일 알림',
        'text': '프로젝트 마감일이 다가옵니다',
      },
      {
        'packageName': 'com.instagram.android',
        'appLabel': 'Instagram',
        'title': 'user123',
        'text': '회원님의 게시물에 좋아요를 눌렀습니다',
      },
    ];

    for (var i = 0; i < testNotifications.length; i++) {
      final notif = testNotifications[i];
      final incoming = IncomingNotification(
        postedAt: now + (i * 1000), // 1초씩 차이
        packageName: notif['packageName']!,
        appLabel: notif['appLabel']!,
        title: notif['title']!,
        text: notif['text']!,
        channelId: 'test_channel',
        category: null,
      );

      await repo.insertNotification(incoming);
    }

    // Provider 갱신
    ref.invalidate(timelineProvider);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('테스트 알림 3개가 추가되었습니다')));
    }
  }

  /// 디버그 정보 표시
  Future<void> _showDebugInfo() async {
    final repo = ref.read(notificationRepoProvider);

    // 전체 알림 수 조회
    final allNotifications = await repo.queryTimeline(limit: 1000000);

    // 현재 필터로 조회한 알림 수
    final filteredNotifications = await repo.queryTimeline(
      category: _filter.category,
      important: _filter.importantOnly ? true : null,
      unread: _filter.unreadOnly ? true : null,
      limit: 5000,
    );

    // 카테고리별 알림 수 조회
    final categoryCount = <String, int>{};
    for (final notif in allNotifications) {
      categoryCount[notif.assignedCategory] =
          (categoryCount[notif.assignedCategory] ?? 0) + 1;
    }

    // 최근 5개 알림 정보
    final recentNotifications = allNotifications.take(5).toList();

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('디버그 정보'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('전체 알림 수: ${allNotifications.length}'),
                Text('필터링된 알림 수: ${filteredNotifications.length}'),
                const SizedBox(height: 16),
                const Text(
                  '카테고리별 알림 수:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...categoryCount.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4),
                    child: Text('${e.key}: ${e.value}'),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '현재 필터:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('카테고리: ${_filter.category?.name ?? "전체"}'),
                      Text('중요: ${_filter.importantOnly}'),
                      Text('읽지 않음: ${_filter.unreadOnly}'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '최근 알림 5개:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...recentNotifications.map(
                  (notif) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${notif.appLabel}: ${notif.title}',
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '카테고리: ${notif.assignedCategory}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTimelineList(List<NotificationEntry> notifications) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(timelineProvider);
        // 새로고침이 완료될 때까지 대기
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationCard(notification);
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationEntry notification) {
    final iconSize = ResponsiveLayout.value(
      context,
      mobile: 40.0,
      tablet: 48.0,
      desktop: 56.0,
    );

    return Card(
      margin: ResponsiveLayout.horizontalPadding(
        context,
      ).add(const EdgeInsets.symmetric(vertical: 8)),
      child: InkWell(
        onTap: () {
          _showNotificationDetail(notification);
        },
        child: Padding(
          padding: ResponsiveLayout.padding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // 앱 아이콘 플레이스홀더
                  Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: CategoryUtils.getCategoryColorFromString(
                        notification.assignedCategory,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      CategoryUtils.getCategoryIconFromString(
                        notification.assignedCategory,
                      ),
                      color: Colors.white,
                      size: iconSize * 0.6,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                notification.appLabel,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
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
                      CategoryUtils.getCategoryLabelFromString(
                        notification.assignedCategory,
                      ),
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: CategoryUtils.getCategoryColorFromString(
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
                          color: CategoryUtils.getCategoryColorFromString(
                            notification.assignedCategory,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          CategoryUtils.getCategoryIconFromString(
                            notification.assignedCategory,
                          ),
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
