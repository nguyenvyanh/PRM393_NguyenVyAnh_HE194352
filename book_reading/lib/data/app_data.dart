import '../models/book.dart';
import '../models/chapter.dart';
import '../models/bookmark.dart';

class AppData {
  static List<BookMark> bookmarks = [];

  static Book? lastBook;

  static Chapter? lastChapter;
}