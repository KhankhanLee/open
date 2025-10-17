class StudyItem {
  final int id;
  final int sourceNotificationId;
  final String lang;
  final String phrase;
  final String translation;
  final int reviewLevel;
  final int createdAt;

  StudyItem({
    required this.id,
    required this.sourceNotificationId,
    required this.lang,
    required this.phrase,
    required this.translation,
    this.reviewLevel = 0,
    required this.createdAt,
  });
}
