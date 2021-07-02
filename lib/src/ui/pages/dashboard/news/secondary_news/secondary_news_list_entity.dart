class SecondaryNewsListEntity {
  final String title;
  final String date;
  final String time;
  final String articleUrl;
  final String? imageUrl;

  SecondaryNewsListEntity({
    required this.title,
    required this.date,
    required this.time,
    required this.articleUrl,
    this.imageUrl,
  });
}
