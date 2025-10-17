import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.timeline), label: '타임라인'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: '카테고리'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '통계'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: '학습'),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/categories');
            break;
          case 2:
            context.go('/statistics');
            break;
          case 3:
            context.go('/learning');
            break;
        }
      },
    );
  }
}
