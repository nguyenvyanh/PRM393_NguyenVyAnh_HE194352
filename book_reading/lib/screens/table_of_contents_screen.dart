import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/chapter.dart';
import '../data/app_data.dart';
import 'reader_screen.dart';

class TableOfContentsScreen extends StatelessWidget {
  final Book book;

  const TableOfContentsScreen({
    super.key,
    required this.book,
  });

  bool hasBookmark(Chapter chapter) {
    return AppData.bookmarks.any(
      (bm) => bm.book.id == book.id && bm.chapter.id == chapter.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: book.chapters.length,
        itemBuilder: (context, index) {
          final chapter = book.chapters[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xff4F63D7),
                foregroundColor: Colors.white,
                child: Text('${index + 1}'),
              ),
              title: Text(
                chapter.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                AppData.lastChapter?.id == chapter.id
                    ? 'Đang đọc'
                    : 'Chưa đọc',
              ),
              trailing: hasBookmark(chapter)
                  ? const Icon(
                      Icons.bookmark,
                      color: Color(0xff4F63D7),
                    )
                  : const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReaderScreen(
                      book: book,
                      chapter: chapter,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}