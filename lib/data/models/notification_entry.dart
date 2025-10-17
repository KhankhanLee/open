import 'package:yeolda/data/models/category.dart';

class NotificationEntry {
  final int id;
  final int postedAt;
  final String packageName;
  final String appLabel;
  final String title;
  final String content;
  final String? channelId;
  final String? category;
  final AppCategory assignedCategory;
  final bool isImportant;
  final bool isRead;
  final String hash;

  NotificationEntry({
    required this.id,
    required this.postedAt,
    required this.packageName,
    required this.appLabel,
    required this.title,
    required this.content,
    this.channelId,
    this.category,
    required this.assignedCategory,
    this.isImportant = false,
    this.isRead = false,
    required this.hash,
  });
}
