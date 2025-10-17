import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/data/models/category.dart';
import 'package:yeolda/data/repo/notification_repo.dart';
import 'package:yeolda/ui/widgets/app_bottom_navigation_bar.dart';

// 통계 데이터 Provider
final statsProvider = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(notificationRepoProvider);

  final results = await Future.wait([
    repo.getStatsByHour(),
    repo.getStatsByWeekday(),
    repo.getStatsByCategory(),
    repo.getTopApps(10),
    repo.getTotalCount(),
    repo.getUnreadCount(),
  ]);

  return StatsData(
    byHour: results[0] as Map<int, int>,
    byWeekday: results[1] as Map<int, int>,
    byCategory: results[2] as Map<AppCategory, int>,
    topApps: results[3] as List<AppStat>,
    totalCount: results[4] as int,
    unreadCount: results[5] as int,
  );
});

class StatsData {
  final Map<int, int> byHour;
  final Map<int, int> byWeekday;
  final Map<AppCategory, int> byCategory;
  final List<AppStat> topApps;
  final int totalCount;
  final int unreadCount;

  StatsData({
    required this.byHour,
    required this.byWeekday,
    required this.byCategory,
    required this.topApps,
    required this.totalCount,
    required this.unreadCount,
  });
}

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('통계'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(statsProvider);
            },
          ),
        ],
      ),
      body: Hero(
        tag: 'screen_hero',
        child: Material(
          child: statsAsync.when(
            data: (stats) => _buildStatsContent(context, stats),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('오류: $error'),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
    );
  }

  Widget _buildStatsContent(BuildContext context, StatsData stats) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSummaryCards(stats),
        const SizedBox(height: 24),
        _buildHourChart(stats),
        const SizedBox(height: 24),
        _buildWeekdayChart(stats),
        const SizedBox(height: 24),
        _buildCategoryChart(stats),
        const SizedBox(height: 24),
        _buildTopApps(stats),
      ],
    );
  }

  Widget _buildSummaryCards(StatsData stats) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.notifications, size: 32, color: Colors.blue),
                  const SizedBox(height: 8),
                  Text(
                    '${stats.totalCount}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('전체 알림'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(
                    Icons.mark_email_unread,
                    size: 32,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${stats.unreadCount}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('읽지 않음'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHourChart(StatsData stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '시간대별 알림',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '← 좌우로 스크롤하세요',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 24 * 40.0, // 24시간 * 40px
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: stats.byHour.values.isEmpty
                          ? 10
                          : stats.byHour.values
                                    .reduce((a, b) => a > b ? a : b)
                                    .toDouble() *
                                1.2,
                      barGroups: List.generate(24, (i) {
                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: (stats.byHour[i] ?? 0).toDouble(),
                              color: Colors.blue,
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        );
                      }),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${value.toInt()}시',
                                  style: const TextStyle(fontSize: 11),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekdayChart(StatsData stats) {
    final weekdays = ['월', '화', '수', '목', '금', '토', '일'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '요일별 알림',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: stats.byWeekday.values.isEmpty
                      ? 10
                      : stats.byWeekday.values
                                .reduce((a, b) => a > b ? a : b)
                                .toDouble() *
                            1.2,
                  barGroups: List.generate(7, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: (stats.byWeekday[i] ?? 0).toDouble(),
                          color: Colors.green,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(weekdays[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChart(StatsData stats) {
    if (stats.byCategory.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('데이터가 없습니다')),
        ),
      );
    }

    final total = stats.byCategory.values.reduce((a, b) => a + b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '카테고리별 알림',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: stats.byCategory.entries.map((entry) {
                    final percentage = (entry.value / total * 100)
                        .toStringAsFixed(1);
                    return PieChartSectionData(
                      value: entry.value.toDouble(),
                      title: '$percentage%',
                      color: _getCategoryColor(entry.key),
                      radius: 80,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: stats.byCategory.entries.map((entry) {
                return Chip(
                  avatar: CircleAvatar(
                    backgroundColor: _getCategoryColor(entry.key),
                  ),
                  label: Text(
                    '${_getCategoryLabel(entry.key)}: ${entry.value}',
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopApps(StatsData stats) {
    if (stats.topApps.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('데이터가 없습니다')),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '앱별 통계 (Top 10)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...stats.topApps.asMap().entries.map((entry) {
              final index = entry.key;
              final app = entry.value;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Colors.primaries[index % Colors.primaries.length],
                  child: Text('${index + 1}'),
                ),
                title: Text(app.appLabel),
                subtitle: Text(app.packageName),
                trailing: Text(
                  '${app.count}개',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(AppCategory category) {
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
  }

  String _getCategoryLabel(AppCategory category) {
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
}
