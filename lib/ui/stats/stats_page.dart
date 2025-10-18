import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/data/models/category.dart';
import 'package:yeolda/data/repo/notification_repo.dart';
import 'package:yeolda/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:yeolda/ui/widgets/category_utils.dart';
import 'package:yeolda/ui/widgets/responsive_layout.dart';

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
    return ResponsiveContainer(
      child: ListView(
        padding: ResponsiveLayout.padding(context),
        children: [
          _buildSummaryCards(context, stats),
          SizedBox(
            height: ResponsiveLayout.value(
              context,
              mobile: 16.0,
              tablet: 24.0,
              desktop: 32.0,
            ),
          ),
          _buildHourChart(context, stats),
          SizedBox(
            height: ResponsiveLayout.value(
              context,
              mobile: 16.0,
              tablet: 24.0,
              desktop: 32.0,
            ),
          ),
          _buildWeekdayChart(context, stats),
          SizedBox(
            height: ResponsiveLayout.value(
              context,
              mobile: 16.0,
              tablet: 24.0,
              desktop: 32.0,
            ),
          ),
          _buildCategoryChart(context, stats),
          SizedBox(
            height: ResponsiveLayout.value(
              context,
              mobile: 16.0,
              tablet: 24.0,
              desktop: 32.0,
            ),
          ),
          _buildTopApps(context, stats),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context, StatsData stats) {
    final cardPadding = ResponsiveLayout.value(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
    );
    final iconSize = ResponsiveLayout.value(
      context,
      mobile: 32.0,
      tablet: 40.0,
      desktop: 48.0,
    );

    return ResponsiveRowColumn(
      spacing: 16,
      children: [
        Flexible(
          flex: 1,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications, size: iconSize, color: Colors.blue),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${stats.totalCount}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const FittedBox(fit: BoxFit.scaleDown, child: Text('전체 알림')),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.mark_email_unread,
                    size: iconSize,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${stats.unreadCount}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const FittedBox(fit: BoxFit.scaleDown, child: Text('읽지 않음')),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHourChart(BuildContext context, StatsData stats) {
    final chartHeight = ResponsiveLayout.value(
      context,
      mobile: 200.0,
      tablet: 250.0,
      desktop: 300.0,
    );
    final barWidth = ResponsiveLayout.value(
      context,
      mobile: 40.0,
      tablet: 50.0,
      desktop: 60.0,
    );

    return Card(
      child: Padding(
        padding: ResponsiveLayout.padding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '시간대별 알림',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 16.0,
                    tablet: 18.0,
                    desktop: 20.0,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '← 좌우로 스크롤하세요',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: chartHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 24 * barWidth,
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

  Widget _buildWeekdayChart(BuildContext context, StatsData stats) {
    final weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final chartHeight = ResponsiveLayout.value(
      context,
      mobile: 200.0,
      tablet: 250.0,
      desktop: 300.0,
    );

    return Card(
      child: Padding(
        padding: ResponsiveLayout.padding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '요일별 알림',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 16.0,
                    tablet: 18.0,
                    desktop: 20.0,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: chartHeight,
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

  Widget _buildCategoryChart(BuildContext context, StatsData stats) {
    if (stats.byCategory.isEmpty) {
      return Card(
        child: Padding(
          padding: ResponsiveLayout.padding(context),
          child: const Center(child: Text('데이터가 없습니다')),
        ),
      );
    }

    final total = stats.byCategory.values.reduce((a, b) => a + b);

    return Card(
      child: Padding(
        padding: ResponsiveLayout.padding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '카테고리별 알림',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 16.0,
                    tablet: 18.0,
                    desktop: 20.0,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                      color: CategoryUtils.getCategoryColor(entry.key),
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
                    backgroundColor: CategoryUtils.getCategoryColor(entry.key),
                  ),
                  label: Text(
                    '${CategoryUtils.getCategoryLabel(entry.key)}: ${entry.value}',
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopApps(BuildContext context, StatsData stats) {
    if (stats.topApps.isEmpty) {
      return Card(
        child: Padding(
          padding: ResponsiveLayout.padding(context),
          child: const Center(child: Text('데이터가 없습니다')),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: ResponsiveLayout.padding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '앱별 통계 (Top 10)',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 16.0,
                    tablet: 18.0,
                    desktop: 20.0,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
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
}
