import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/services/notification_listener.dart';
import 'package:go_router/go_router.dart';
import 'package:yeolda/ui/widgets/responsive_layout.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildWelcomePage(),
                  _buildPermissionPage(),
                  _buildCategoryPage(),
                ],
              ),
            ),
            _buildPageIndicator(),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return ResponsiveContainer(
      child: Padding(
        padding: ResponsiveLayout.padding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_active,
              size: ResponsiveLayout.value(
                context,
                mobile: 100.0,
                tablet: 120.0,
                desktop: 140.0,
              ),
              color: Colors.blue,
            ),
            const SizedBox(height: 32),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '열다 | Open',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 28.0,
                    tablet: 32.0,
                    desktop: 36.0,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '모든 알림을 한곳에서\n자동으로 분류하고 관리하세요',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveLayout.value(
                  context,
                  mobile: 16.0,
                  tablet: 18.0,
                  desktop: 20.0,
                ),
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 48),
            _buildFeatureItem(
              Icons.category,
              '자동 분류',
              '메신저, 공부, 금융, 일정 등으로 자동 분류',
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(Icons.timeline, '타임라인', '모든 알림을 시간순으로 확인'),
            const SizedBox(height: 16),
            _buildFeatureItem(Icons.school, '학습 기능', '알림 속 외국어 문장으로 학습'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    final iconSize = ResponsiveLayout.value(
      context,
      mobile: 32.0,
      tablet: 40.0,
      desktop: 48.0,
    );

    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: iconSize),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionPage() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.security, size: 120, color: Colors.orange),
          const SizedBox(height: 32),
          const Text(
            '알림 접근 권한',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            '앱이 알림을 수집하려면\n알림 접근 권한이 필요합니다',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 48),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.privacy_tip, color: Colors.blue),
                const SizedBox(height: 8),
                const Text(
                  '개인정보 보호',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• 모든 데이터는 기기에만 저장됩니다\n'
                  '• 외부로 전송되지 않습니다\n'
                  '• 언제든 삭제할 수 있습니다',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () async {
              await NotificationListenerService.openSettings();
            },
            icon: const Icon(Icons.settings),
            label: const Text('권한 설정 열기'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPage() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 120, color: Colors.green),
          const SizedBox(height: 32),
          const Text(
            '준비 완료!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            '알림은 자동으로 다음 카테고리로 분류됩니다',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          _buildCategoryChip('💬', '메신저', Colors.blue),
          const SizedBox(height: 12),
          _buildCategoryChip('📚', '공부', Colors.purple),
          const SizedBox(height: 12),
          _buildCategoryChip('💰', '금융', Colors.green),
          const SizedBox(height: 12),
          _buildCategoryChip('📅', '일정', Colors.orange),
          const SizedBox(height: 12),
          _buildCategoryChip('🛍️', '쇼핑', Colors.pink),
          const SizedBox(height: 12),
          _buildCategoryChip('📰', '뉴스', Colors.red),
          const SizedBox(height: 12),
          _buildCategoryChip('📱', '기타', Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String emoji, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: _currentPage == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: _currentPage == index ? Colors.blue : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            TextButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('이전'),
            )
          else
            const SizedBox(width: 80),
          ElevatedButton(
            onPressed: () {
              if (_currentPage < 2) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                // 온보딩 완료
                context.go('/home');
              }
            },
            child: Text(_currentPage < 2 ? '다음' : '시작하기'),
          ),
        ],
      ),
    );
  }
}
