import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/chapter.dart';
import '../models/bookmark.dart';
import '../data/app_data.dart';
import 'table_of_contents_screen.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;
  final Chapter chapter;

  const ReaderScreen({
    super.key,
    required this.book,
    required this.chapter,
  });

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late Chapter currentChapter;

  @override
  void initState() {
    super.initState();
    currentChapter = widget.chapter;
    saveProgress();
  }

  void saveProgress() {
    AppData.lastBook = widget.book;
    AppData.lastChapter = currentChapter;
  }

  bool isBookmarked() {
    return AppData.bookmarks.any(
      (bm) =>
          bm.book.id == widget.book.id && bm.chapter.id == currentChapter.id,
    );
  }

  void toggleBookmark() {
    setState(() {
      if (isBookmarked()) {
        AppData.bookmarks.removeWhere(
          (bm) =>
              bm.book.id == widget.book.id &&
              bm.chapter.id == currentChapter.id,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã xóa bookmark')),
        );
      } else {
        AppData.bookmarks.add(
          BookMark(
            book: widget.book,
            chapter: currentChapter,
            createdAt: DateTime.now(),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã thêm bookmark')),
        );
      }
    });
  }

  void goToChapter(int newIndex) {
    setState(() {
      currentChapter = widget.book.chapters[newIndex];
      saveProgress();
    });
  }

  void previousChapter() {
    final currentIndex = widget.book.chapters.indexWhere(
      (c) => c.id == currentChapter.id,
    );

    if (currentIndex > 0) {
      goToChapter(currentIndex - 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đây là chương đầu tiên')),
      );
    }
  }

  void nextChapter() {
    final currentIndex = widget.book.chapters.indexWhere(
      (c) => c.id == currentChapter.id,
    );

    if (currentIndex < widget.book.chapters.length - 1) {
      goToChapter(currentIndex + 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đây là chương cuối cùng')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool bookmarked = isBookmarked();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đọc sách'),
        actions: [
          IconButton(
            onPressed: toggleBookmark,
            icon: Icon(
              bookmarked ? Icons.bookmark : Icons.bookmark_border,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            widget.book.title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentChapter.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff26315F),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            currentChapter.content,
            style: const TextStyle(
              fontSize: 18,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: previousChapter,
                child: const Text('Chương trước'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TableOfContentsScreen(book: widget.book),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4F63D7),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Mục lục'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: nextChapter,
                child: const Text('Chương sau'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}