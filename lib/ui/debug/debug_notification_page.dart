import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeolda/services/notification_listener.dart';
import 'package:yeolda/core/providers.dart';

/// 디버그용 알림 테스트 페이지
class DebugNotificationPage extends ConsumerStatefulWidget {
  const DebugNotificationPage({super.key});

  @override
  ConsumerState<DebugNotificationPage> createState() =>
      _DebugNotificationPageState();
}

class _DebugNotificationPageState extends ConsumerState<DebugNotificationPage> {
  final List<String> _logs = [];
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    setState(() {
      _isListening = true;
      _logs.add('[${DateTime.now()}] 알림 리스닝 시작...');
    });

    final service = NotificationListenerService();
    service.notificationStream.listen(
      (notification) {
        setState(() {
          _logs.add(
            '[${DateTime.now()}] 📱 알림 수신:\n'
            '  앱: ${notification.appLabel}\n'
            '  제목: ${notification.title}\n'
            '  내용: ${notification.text}\n'
            '  패키지: ${notification.packageName}',
          );
        });

        // DB 저장 시도
        _saveToDatabase(notification);
      },
      onError: (error) {
        setState(() {
          _logs.add('[${DateTime.now()}] 오류: $error');
        });
      },
    );
  }

  Future<void> _saveToDatabase(IncomingNotification notification) async {
    try {
      final repo = ref.read(notificationRepoProvider);
      final success = await repo.insertNotification(notification);

      setState(() {
        if (success) {
          _logs.add('[${DateTime.now()}] DB 저장 성공');
        } else {
          _logs.add('[${DateTime.now()}] DB 저장 실패 (중복?)');
        }
      });
    } catch (e) {
      setState(() {
        _logs.add('[${DateTime.now()}] DB 저장 오류: $e');
      });
    }
  }

  Future<void> _checkPermission() async {
    final hasPermission = await NotificationListenerService.checkPermission();
    setState(() {
      _logs.add('[${DateTime.now()}] 권한 상태: ${hasPermission ? "허용됨" : "거부됨"}');
    });

    if (!hasPermission && mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('알림 접근 권한 필요'),
          content: const Text('앱이 알림을 읽으려면 알림 접근 권한이 필요합니다.\n설정으로 이동하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                NotificationListenerService.openSettings();
              },
              child: const Text('설정 열기'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _checkDatabaseCount() async {
    try {
      final repo = ref.read(notificationRepoProvider);
      final count = await repo.getTotalCount();
      setState(() {
        _logs.add('[${DateTime.now()}] DB에 저장된 알림 수: $count개');
      });
    } catch (e) {
      setState(() {
        _logs.add('[${DateTime.now()}] DB 조회 오류: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 디버그'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _logs.clear();
              });
            },
            tooltip: '로그 지우기',
          ),
        ],
      ),
      body: Column(
        children: [
          // 상태 패널
          Container(
            width: double.infinity,
            color: _isListening ? Colors.green.shade50 : Colors.red.shade50,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _isListening ? Icons.circle : Icons.circle_outlined,
                      color: _isListening ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isListening ? '리스닝 중...' : '리스닝 중지됨',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _isListening ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '다른 앱에서 알림을 발생시키면\n여기에 실시간으로 표시됩니다',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          // 액션 버튼들
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _checkPermission,
                  icon: const Icon(Icons.security, size: 16),
                  label: const Text('권한 확인'),
                ),
                ElevatedButton.icon(
                  onPressed: _checkDatabaseCount,
                  icon: const Icon(Icons.storage, size: 16),
                  label: const Text('DB 확인'),
                ),
                ElevatedButton.icon(
                  onPressed: NotificationListenerService.openSettings,
                  icon: const Icon(Icons.settings, size: 16),
                  label: const Text('설정 열기'),
                ),
              ],
            ),
          ),

          const Divider(),

          // 로그 영역
          Expanded(
            child: _logs.isEmpty
                ? const Center(
                    child: Text(
                      '📋 로그가 비어있습니다\n\n위의 버튼을 눌러 테스트하거나\n다른 앱에서 알림을 발생시켜보세요',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      final log = _logs[_logs.length - 1 - index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SelectableText(
                            log,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _logs.add('[${DateTime.now()}] 수동 새로고침');
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
