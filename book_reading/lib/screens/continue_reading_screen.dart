import 'package:flutter/material.dart';
import '../data/app_data.dart';
import 'reader_screen.dart';

class ContinueReadingScreen extends StatelessWidget {
  final VoidCallback onGoLibrary;

  const ContinueReadingScreen({
    super.key,
    required this.onGoLibrary,
  });

  @override
  Widget build(BuildContext context) {
    final book = AppData.lastBook;
    final chapter = AppData.lastChapter;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đang đọc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: book == null || chapter == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.menu_book,
                      size: 70,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Bạn chưa đọc sách nào',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: onGoLibrary,
                      child: const Text('Mở thư viện'),
                    ),
                  ],
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const Icon(
                    Icons.menu_book,
                    size: 42,
                    color: Color(0xff4F63D7),
                  ),
                  title: Text(
                    book.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(chapter.title),
                  trailing: const Icon(Icons.arrow_forward_ios),
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
              ),
      ),
    );
  }
}