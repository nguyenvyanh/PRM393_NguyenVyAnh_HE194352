import 'package:flutter/material.dart';
import 'library_screen.dart';
import 'continue_reading_screen.dart';
import 'bookmark_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget getCurrentScreen() {
    if (selectedIndex == 0) {
      return const LibraryScreen();
    } else if (selectedIndex == 1) {
      return ContinueReadingScreen(
        onGoLibrary: () => changeTab(0),
      );
    } else {
      return BookmarkScreen(
        onBookmarkChanged: () {
          setState(() {});
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xff4F63D7),
        unselectedItemColor: Colors.grey,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Đang đọc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
        ],
      ),
    );
  }
}