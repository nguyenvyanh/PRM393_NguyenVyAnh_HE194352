import 'book.dart';
import 'chapter.dart';

class BookMark {
  final Book book;
  final Chapter chapter;
  final DateTime createdAt;

  BookMark({
    required this.book,
    required this.chapter,
    required this.createdAt,
  });
}