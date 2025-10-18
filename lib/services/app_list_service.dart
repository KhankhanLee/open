import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class InstalledApp {
  final String packageName;
  final String appLabel;

  InstalledApp({required this.packageName, required this.appLabel});

  factory InstalledApp.fromMap(Map<dynamic, dynamic> map) {
    return InstalledApp(
      packageName: map['packageName'] as String,
      appLabel: map['appLabel'] as String,
    );
  }
}

class AppListService {
  static const MethodChannel _channel = MethodChannel('yeolda/app_list');

  /// 사용자 폰에 설치된 모든 앱 목록 가져오기
  static Future<List<InstalledApp>> getInstalledApps() async {
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        'getInstalledApps',
      );
      return result
          .map((app) => InstalledApp.fromMap(app as Map<dynamic, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting installed apps: $e');
      return [];
    }
  }
}
