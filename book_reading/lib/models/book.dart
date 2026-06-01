import 'chapter.dart';

class Book {
  final int id;
  final String title;
  final String author;
  final String description;
  final List<Chapter> chapters;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.chapters,
  });
}