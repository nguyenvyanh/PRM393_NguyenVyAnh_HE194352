import 'package:flutter/material.dart';
import '../data/app_data.dart';
import 'reader_screen.dart';

class BookmarkScreen extends StatelessWidget {
  final VoidCallback onBookmarkChanged;

  const BookmarkScreen({
    super.key,
    required this.onBookmarkChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bookmarks = AppData.bookmarks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark của tôi'),
      ),
      body: bookmarks.isEmpty
          ? const Center(
              child: Text(
                'Chưa có bookmark nào',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final bm = bookmarks[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.bookmark,
                      color: Color(0xff4F63D7),
                    ),
                    title: Text(
                      bm.book.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${bm.chapter.title}\nĐã lưu: ${bm.createdAt.day}/${bm.createdAt.month}/${bm.createdAt.year}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        AppData.bookmarks.removeAt(index);
                        onBookmarkChanged();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đã xóa bookmark')),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReaderScreen(
                            book: bm.book,
                            chapter: bm.chapter,
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