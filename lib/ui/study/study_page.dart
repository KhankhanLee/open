import 'package:flutter/material.dart';
import 'package:yeolda/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:yeolda/ui/study/language_learning_page.dart';
import 'package:yeolda/ui/widgets/responsive_layout.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('학습')),
      body: SingleChildScrollView(
        child: Column(
          children: [_buildHeader(context), _buildStudyOptions(context)],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 4),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: ResponsiveLayout.padding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '언어를 배우고 실력을 키워보세요! 🚀',
            style: TextStyle(
              fontSize: ResponsiveLayout.value(
                context,
                mobile: 20.0,
                tablet: 24.0,
                desktop: 28.0,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '재미있게 외국어를 배워보세요',
            style: TextStyle(
              fontSize: ResponsiveLayout.value(
                context,
                mobile: 14.0,
                tablet: 16.0,
                desktop: 18.0,
              ),
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyOptions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: ResponsiveLayout.gridColumns(context),
      padding: ResponsiveLayout.padding(context),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: ResponsiveLayout.value(
        context,
        mobile: 1.0,
        tablet: 1.2,
        desktop: 1.3,
      ),
      children: [
        _buildStudyCard(
          context,
          icon: Icons.translate,
          title: '언어 학습',
          description: '기본 단어 1000개로 시작하세요',
          color: Colors.blue,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LanguageLearningPage(),
              ),
            );
          },
        ),
        _buildStudyCard(
          context,
          icon: Icons.quiz,
          title: '퀴즈',
          description: '학습한 내용을 확인하세요',
          color: Colors.orange,
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('퀴즈 기능 준비 중')));
          },
        ),
        _buildStudyCard(
          context,
          icon: Icons.leaderboard,
          title: '통계',
          description: '학습 진행도를 확인하세요',
          color: Colors.green,
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('통계 기능 준비 중')));
          },
        ),
        _buildStudyCard(
          context,
          icon: Icons.auto_stories,
          title: '스토리',
          description: '재미있는 이야기로 배우세요',
          color: Colors.purple,
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('스토리 기능 준비 중')));
          },
        ),
      ],
    );
  }

  Widget _buildStudyCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: ResponsiveLayout.value(
                    context,
                    mobile: 32.0,
                    tablet: 40.0,
                    desktop: 48.0,
                  ),
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 14.0,
                    tablet: 16.0,
                    desktop: 18.0,
                  ),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 11.0,
                    tablet: 12.0,
                    desktop: 14.0,
                  ),
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
