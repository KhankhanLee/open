import 'package:flutter/material.dart';
import 'package:yeolda/data/models/vocabulary_data.dart';
import 'package:yeolda/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:yeolda/ui/widgets/responsive_layout.dart';

class LanguageLearningPage extends StatefulWidget {
  const LanguageLearningPage({super.key});

  @override
  State<LanguageLearningPage> createState() => _LanguageLearningPageState();
}

class _LanguageLearningPageState extends State<LanguageLearningPage> {
  LanguageType _selectedLanguage = LanguageType.english;
  final Map<LanguageType, int> _progress = {
    LanguageType.english: 0,
    LanguageType.japanese: 0,
    LanguageType.spanish: 0,
    LanguageType.german: 0,
  };

  @override
  Widget build(BuildContext context) {
    final words = VocabularyData.getWordsForLanguage(_selectedLanguage);
    final progress = _progress[_selectedLanguage] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('언어 학습'),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              // TODO: 통계 페이지
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('통계 기능 준비 중')));
            },
          ),
        ],
      ),
      body: ResponsiveContainer(
        child: Column(
          children: [
            _buildLanguageSelector(context),
            _buildProgressBar(context, progress, words.length),
            Expanded(child: _buildVocabularyList(context, words)),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 4),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return Container(
      padding: ResponsiveLayout.padding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '학습할 언어를 선택하세요',
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
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: LanguageType.values.map((language) {
                final isSelected = language == _selectedLanguage;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _buildLanguageCard(context, language, isSelected),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(
    BuildContext context,
    LanguageType language,
    bool isSelected,
  ) {
    final iconMap = {
      LanguageType.english: '🇺🇸',
      LanguageType.japanese: '🇯🇵',
      LanguageType.spanish: '🇪🇸',
      LanguageType.german: '🇩🇪',
    };

    return InkWell(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: Container(
        width: ResponsiveLayout.value(
          context,
          mobile: 120.0,
          tablet: 140.0,
          desktop: 160.0,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              iconMap[language]!,
              style: TextStyle(
                fontSize: ResponsiveLayout.value(
                  context,
                  mobile: 32.0,
                  tablet: 40.0,
                  desktop: 48.0,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              language.label,
              style: TextStyle(
                fontSize: ResponsiveLayout.value(
                  context,
                  mobile: 14.0,
                  tablet: 16.0,
                  desktop: 18.0,
                ),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, int progress, int total) {
    final percentage = (progress / total * 100).clamp(0, 100);

    return Container(
      padding: ResponsiveLayout.padding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '학습 진행도',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 14.0,
                    tablet: 16.0,
                    desktop: 18.0,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$progress / $total 단어 (${percentage.toStringAsFixed(1)}%)',
                style: TextStyle(
                  fontSize: ResponsiveLayout.value(
                    context,
                    mobile: 12.0,
                    tablet: 14.0,
                    desktop: 16.0,
                  ),
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress / total,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVocabularyList(
    BuildContext context,
    List<VocabularyWord> words,
  ) {
    // 카테고리별로 그룹화
    final Map<String, List<VocabularyWord>> groupedWords = {};
    for (final word in words) {
      groupedWords.putIfAbsent(word.category, () => []).add(word);
    }

    return ListView.builder(
      padding: ResponsiveLayout.padding(context),
      itemCount: groupedWords.length,
      itemBuilder: (context, index) {
        final category = groupedWords.keys.elementAt(index);
        final categoryWords = groupedWords[category]!;

        return _buildCategorySection(context, category, categoryWords);
      },
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String category,
    List<VocabularyWord> words,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(_getCategoryIcon(category), color: Colors.blue),
        ),
        title: Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text('${words.length}개 단어'),
        children: words.map((word) => _buildWordItem(context, word)).toList(),
      ),
    );
  }

  Widget _buildWordItem(BuildContext context, VocabularyWord word) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check_circle, color: Colors.green),
      ),
      title: Text(
        word.word,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(word.translation),
          if (word.pronunciation != null)
            Text(
              word.pronunciation!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          if (word.example != null)
            Text(
              word.example!,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.blue),
            onPressed: () {
              // TODO: TTS (Text-to-Speech)
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('발음: ${word.word}')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.quiz, color: Colors.orange),
            onPressed: () {
              // TODO: 퀴즈 시작
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('${word.word} 퀴즈 시작')));
            },
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case '인사':
        return Icons.waving_hand;
      case '기본':
        return Icons.star;
      case '형용사':
        return Icons.description;
      case '감정':
        return Icons.emoji_emotions;
      case '숫자':
        return Icons.numbers;
      case '가족':
        return Icons.family_restroom;
      case '음식':
        return Icons.restaurant;
      case '동물':
        return Icons.pets;
      case '색상':
        return Icons.palette;
      case '동사':
        return Icons.directions_run;
      default:
        return Icons.book;
    }
  }
}
