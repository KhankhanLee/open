import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yeolda/bootstrap.dart';
import 'package:yeolda/ui/home/timeline_page.dart';
import 'package:yeolda/ui/settings/settings_page.dart';
import 'package:yeolda/ui/stats/stats_page.dart';
import 'package:yeolda/ui/categories/categories_page.dart';
import 'package:yeolda/ui/study/study_page.dart';
import 'package:yeolda/ui/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = await bootstrap();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: '열다 | Open',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false, // DEBUG 배너 제거
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/', redirect: (context, state) => '/home'),
    GoRoute(path: '/home', builder: (context, state) => const TimelinePage()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/statistics',
      builder: (context, state) => const StatsPage(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesPage(),
    ),
    GoRoute(path: '/learning', builder: (context, state) => const StudyPage()),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('오류')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('페이지를 찾을 수 없습니다: ${state.matchedLocation}'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('홈으로 이동'),
          ),
        ],
      ),
    ),
  ),
);
