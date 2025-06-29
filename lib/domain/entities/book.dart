class Book {
  final int id;
  final String title;
  final String summary;
  final String imageUrl;
  final String textUrl;
  final String author;
  final String birthYear;
  final String deathYear;
  final int downloadCount;
  final bool isFavorite;

  const Book({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.textUrl,
    required this.author,
    required this.birthYear,
    required this.deathYear,
    required this.downloadCount,
    this.isFavorite = false
  });
}
