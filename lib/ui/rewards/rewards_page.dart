import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/data/models/reward.dart';

class RewardsPage extends ConsumerStatefulWidget {
  const RewardsPage({super.key});

  @override
  ConsumerState<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends ConsumerState<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    final balanceAsync = ref.watch(userBalanceProvider);
    final rewardRepo = ref.watch(rewardRepoProvider);

    return Hero(
      tag: 'screen_hero',
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 246, 246),
        appBar: AppBar(
          title: const Text('리워드'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                GoRouter.of(context).go('/');
              },
              tooltip: '홈으로',
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // 상단 잔액 표시
              _buildBalanceHeader(balanceAsync),
      
              // 탭 뷰
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Theme.of(context).primaryColor,
                        tabs: const [
                          Tab(text: '리워드 받기'),
                          Tab(text: '히스토리'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildEarnTab(rewardRepo),
                            _buildHistoryTab(rewardRepo),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceHeader(AsyncValue balanceAsync) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withValues(alpha:0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            '내 포인트',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          balanceAsync.when(
            data: (balance) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${balance.availablePoints}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'P',
                  style: TextStyle(color: Colors.white70, fontSize: 24),
                ),
              ],
            ),
            loading: () => const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            error: (error, stack) =>
                Text('로드 실패', style: TextStyle(color: Colors.red[300])),
          ),
          const SizedBox(height: 12),
          balanceAsync.when(
            data: (balance) => Text(
              '총 획득: ${balance.totalPoints}P | 사용: ${balance.usedPoints}P',
              style: const TextStyle(color: Colors.white60, fontSize: 14),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildEarnTab(rewardRepo) {
    return _buildEarnList(rewardRepo);
  }

  Widget _buildEarnList(rewardRepo) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildRewardCard(
          icon: Icons.calendar_today,
          title: '일일 출석 보너스',
          description: '매일 앱에 접속하고 보상을 받으세요',
          points: RewardAmount.dailyBonus,
          onTap: () => _claimDailyBonus(rewardRepo),
        ),
        const SizedBox(height: 12),
        _buildRewardCard(
          icon: Icons.notifications_active,
          title: '알림 확인',
          description: '알림을 읽고 정리하세요',
          points: RewardAmount.notificationRead,
          onTap: () => _showInfo('알림 페이지에서 알림을 확인하면 자동으로 포인트가 지급됩니다'),
        ),
        const SizedBox(height: 12),
        _buildRewardCard(
          icon: Icons.school,
          title: '언어 학습 완료',
          description: '학습 세션을 완료하세요',
          points: RewardAmount.studyComplete,
          onTap: () => _showInfo('학습 페이지에서 단어를 학습하면 자동으로 포인트가 지급됩니다'),
        ),
        const SizedBox(height: 12),
        _buildRewardCard(
          icon: Icons.category,
          title: '카테고리 정리',
          description: '알림을 카테고리별로 정리하세요',
          points: RewardAmount.categoryOrganize,
          onTap: () => _showInfo('카테고리를 추가하거나 앱을 분류하면 자동으로 포인트가 지급됩니다'),
        ),
        const SizedBox(height: 12),
        _buildRewardCard(
          icon: Icons.play_circle_outline,
          title: '광고 시청',
          description: '짧은 광고를 시청하고 포인트를 받으세요',
          points: RewardAmount.adReward,
          color: const Color(0xFFFFD700),
          onTap: () => _showAdReward(rewardRepo),
        ),
        const SizedBox(height: 24),
        _buildInfoSection(),
      ],
    );
  }

  Widget _buildRewardCard({
    required IconData icon,
    required String title,
    required String description,
    required int points,
    required VoidCallback onTap,
    Color? color,
  }) {
    final cardColor = color ?? Theme.of(context).primaryColor;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardColor.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: cardColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: cardColor.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cardColor, width: 1.5),
                ),
                child: Text(
                  '+$points P',
                  style: TextStyle(
                    color: cardColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  '포인트 사용처',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoItem('• 언어 학습 힌트 잠금 해제'),
            _buildInfoItem('• 고급 통계 및 분석 기능'),
            _buildInfoItem('• 프리미엄 테마 및 아이콘'),
            _buildInfoItem('• 추가 기능 잠금 해제 (개발 예정)'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey[600], fontSize: 14),
      ),
    );
  }

  Widget _buildHistoryTab(rewardRepo) {
    return FutureBuilder(
      future: rewardRepo.getRewardHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF4A90E2)),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('히스토리 로드 실패', style: TextStyle(color: Colors.red[300])),
          );
        }

        final rewards = snapshot.data as List<Reward>;

        if (rewards.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 64, color: Colors.white24),
                SizedBox(height: 16),
                Text(
                  '아직 리워드 내역이 없습니다',
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            final reward = rewards[index];
            return _buildHistoryItem(reward);
          },
        );
      },
    );
  }

  Widget _buildHistoryItem(Reward reward) {
    final isPositive = reward.amount > 0;
    final icon = _getRewardIcon(reward.type);
    final title = _getRewardTitle(reward.type);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isPositive ? Colors.green : Colors.red).withValues(alpha:0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isPositive ? Colors.green : Colors.red,
            size: 24,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: reward.description != null
            ? Text(
                reward.description!,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              )
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isPositive ? '+' : ''}${reward.amount} P',
              style: TextStyle(
                color: isPositive ? Colors.green : Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _formatTime(reward.earnedAt),
              style: TextStyle(color: Colors.grey[400], fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getRewardIcon(String type) {
    switch (type) {
      case 'daily_bonus':
        return Icons.calendar_today;
      case 'ad_reward':
        return Icons.play_circle_outline;
      case 'study_complete':
        return Icons.school;
      case 'notification_read':
        return Icons.notifications_active;
      case 'category_organize':
        return Icons.category;
      case 'use_points':
        return Icons.shopping_cart;
      default:
        return Icons.star;
    }
  }

  String _getRewardTitle(String type) {
    switch (type) {
      case 'daily_bonus':
        return '일일 출석 보너스';
      case 'ad_reward':
        return '광고 시청 보상';
      case 'study_complete':
        return '언어 학습 완료';
      case 'notification_read':
        return '알림 확인';
      case 'category_organize':
        return '카테고리 정리';
      case 'use_points':
        return '포인트 사용';
      default:
        return '리워드';
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) {
      return '방금 전';
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inDays < 1) {
      return '${diff.inHours}시간 전';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}일 전';
    } else {
      return '${time.month}/${time.day}';
    }
  }

  Future<void> _claimDailyBonus(rewardRepo) async {
    // 오늘 이미 받았는지 확인
    final hasBonus = await rewardRepo.hasDailyBonusToday();

    if (hasBonus) {
      _showError('오늘은 이미 출석 보너스를 받았습니다!\n내일 다시 방문해주세요 😊');
      return;
    }

    // 보너스 지급
    final success = await rewardRepo.grantReward(
      type: RewardType.dailyBonus,
      amount: RewardAmount.dailyBonus,
      description: '일일 출석 보너스',
    );

    if (success) {
      setState(() {
        // 잔액 업데이트
        ref.invalidate(userBalanceProvider);
      });
      _showSuccess('${RewardAmount.dailyBonus}P를 받았습니다! 🎉');
    } else {
      _showError('보너스 지급에 실패했습니다');
    }
  }

  Future<void> _showAdReward(rewardRepo) async {
    // TODO: 실제 광고 SDK 통합 (Google AdMob, Unity Ads 등)
    // 현재는 데모용으로 즉시 지급

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text('광고 시청', style: TextStyle(color: Colors.white)),
        content: const Text(
          '광고를 시청하시겠습니까?\n(데모 버전: 즉시 포인트 지급)',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
            ),
            child: const Text('시청하기'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await rewardRepo.grantReward(
        type: RewardType.adReward,
        amount: RewardAmount.adReward,
        description: '광고 시청 보상',
      );

      if (success) {
        setState(() {
          ref.invalidate(userBalanceProvider);
        });
        _showSuccess('${RewardAmount.adReward}P를 받았습니다! 🎉');
      }
    }
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF4A90E2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
