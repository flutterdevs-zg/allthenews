class PrimaryNewsListEntity {
  final String? imageUrl;
  final String title;
  final String date;
  final String time;
  final String authorName;
  final String articleUrl;

  PrimaryNewsListEntity({
    this.imageUrl,
    required this.title,
    required this.date,
    required this.time,
    required this.authorName,
    required this.articleUrl,
  });
}
