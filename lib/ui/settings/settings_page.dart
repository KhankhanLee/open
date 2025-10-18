import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/core/providers.dart';
import 'package:yeolda/services/notification_listener.dart';
import 'package:yeolda/ui/categories/custom_categories_page.dart';
import 'package:yeolda/ui/debug/debug_notification_page.dart';
import 'package:yeolda/ui/widgets/app_bottom_navigation_bar.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        children: [
          _buildSectionHeader('알림 권한'),
          _buildPermissionTile(context),
          const Divider(),

          _buildSectionHeader('카테고리'),
          _buildCustomCategoriesTile(context),
          const Divider(),

          _buildSectionHeader('데이터 관리'),
          _buildDeleteOldTile(context, ref),
          _buildDeleteAllTile(context, ref),
          const Divider(),

          _buildSectionHeader('통계'),
          _buildStatsTile(context, ref),
          const Divider(),

          _buildSectionHeader('정보'),
          _buildAboutTile(context),
          _buildPrivacyTile(context),
          const Divider(),

          _buildSectionHeader('개발자'),
          _buildDebugTile(context),

          const SizedBox(height: 32),
          _buildVersionInfo(),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildPermissionTile(BuildContext context) {
    return FutureBuilder<bool>(
      future: NotificationListenerService.checkPermission(),
      builder: (context, snapshot) {
        final hasPermission = snapshot.data ?? false;
        return ListTile(
          leading: Icon(
            hasPermission ? Icons.check_circle : Icons.warning,
            color: hasPermission ? Colors.green : Colors.orange,
          ),
          title: const Text('알림 접근 권한'),
          subtitle: Text(hasPermission ? '권한이 허용되었습니다' : '권한이 필요합니다'),
          trailing: hasPermission
              ? null
              : TextButton(
                  onPressed: () {
                    NotificationListenerService.openSettings();
                  },
                  child: const Text('설정'),
                ),
        );
      },
    );
  }

  Widget _buildCustomCategoriesTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.category),
      title: const Text('커스텀 카테고리 관리'),
      subtitle: const Text('나만의 카테고리 추가 및 관리'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomCategoriesPage(),
          ),
        );
      },
    );
  }

  Widget _buildDeleteOldTile(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.auto_delete),
      title: const Text('오래된 알림 삭제'),
      subtitle: const Text('30일 이전 알림 삭제'),
      onTap: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('알림 삭제'),
            content: const Text('30일 이전의 알림을 모두 삭제하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('삭제'),
              ),
            ],
          ),
        );

        if (confirm == true && context.mounted) {
          final repo = ref.read(notificationRepoProvider);
          final date = DateTime.now().subtract(const Duration(days: 30));
          await repo.deleteOlderThan(date);

          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('오래된 알림이 삭제되었습니다')));
          }
        }
      },
    );
  }

  Widget _buildDeleteAllTile(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.delete_forever, color: Colors.red),
      title: const Text('모든 알림 삭제'),
      subtitle: const Text('저장된 모든 알림 데이터 삭제'),
      onTap: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('모든 알림 삭제'),
            content: const Text('저장된 모든 알림을 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
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

        if (confirm == true && context.mounted) {
          final repo = ref.read(notificationRepoProvider);
          await repo.deleteAll();

          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('모든 알림이 삭제되었습니다')));
          }
        }
      },
    );
  }

  Widget _buildStatsTile(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: Future.wait([
        ref.read(notificationRepoProvider).getTotalCount(),
        ref.read(notificationRepoProvider).getUnreadCount(),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const ListTile(
            leading: Icon(Icons.info),
            title: Text('통계'),
            subtitle: Text('로딩 중...'),
          );
        }

        final data = snapshot.data as List<int>;
        final total = data[0];
        final unread = data[1];

        return ListTile(
          leading: const Icon(Icons.info),
          title: const Text('저장된 알림'),
          subtitle: Text('전체: $total개 | 읽지 않음: $unread개'),
        );
      },
    );
  }

  Widget _buildAboutTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('앱 정보'),
      onTap: () {
        showAboutDialog(
          context: context,
          applicationName: '열다 | Open',
          applicationVersion: '1.0.0',
          applicationIcon: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_active,
              color: Colors.white,
              size: 32,
            ),
          ),
          children: [
            const Text('모든 알림을 자동으로 분류하고 관리하는 앱입니다.'),
            const SizedBox(height: 16),
            const Text('주요 기능:'),
            const Text('• 자동 분류'),
            const Text('• 타임라인'),
            const Text('• 통계'),
            const Text('• 학습 기능'),
          ],
        );
      },
    );
  }

  Widget _buildPrivacyTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.privacy_tip),
      title: const Text('개인정보 처리방침'),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('개인정보 처리방침'),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '데이터 수집 및 저장',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• 모든 알림 데이터는 사용자 기기에만 저장됩니다\n'
                    '• 외부 서버로 데이터가 전송되지 않습니다\n'
                    '• 수집된 데이터: 알림 제목, 내용, 앱 이름, 시간',
                  ),
                  SizedBox(height: 16),
                  Text('데이터 사용', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    '• 알림 자동 분류\n'
                    '• 통계 생성\n'
                    '• 학습 자료 제공',
                  ),
                  SizedBox(height: 16),
                  Text('데이터 삭제', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    '• 설정에서 언제든 데이터를 삭제할 수 있습니다\n'
                    '• 앱 삭제 시 모든 데이터가 함께 삭제됩니다',
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
      },
    );
  }

  Widget _buildDebugTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.bug_report),
      title: const Text('알림 디버그'),
      subtitle: const Text('실시간 알림 수신 테스트'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DebugNotificationPage(),
          ),
        );
      },
    );
  }

  Widget _buildVersionInfo() {
    return Center(
      child: Column(
        children: [
          Text(
            '열다 | Open',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            'v1.0.0',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
