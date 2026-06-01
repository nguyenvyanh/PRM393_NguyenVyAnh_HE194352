import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/chapter.dart';
import '../data/app_data.dart';
import 'reader_screen.dart';
import 'table_of_contents_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final Chapter firstChapter = book.chapters.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sách'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: const Color(0xff4F63D7),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Center(
              child: Text(
                book.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            book.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xff26315F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tác giả: ${book.author}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            book.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Số chương: ${book.chapters.length}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Chapter chapterToRead = AppData.lastBook?.id == book.id
                  ? AppData.lastChapter ?? firstChapter
                  : firstChapter;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReaderScreen(
                    book: book,
                    chapter: chapterToRead,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Đọc ngay'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4F63D7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TableOfContentsScreen(book: book),
                ),
              );
            },
            icon: const Icon(Icons.list),
            label: const Text('Xem mục lục'),
          ),
        ],
      ),
    );
  }
}