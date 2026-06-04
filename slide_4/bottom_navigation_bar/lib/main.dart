import 'package:flutter/material.dart';
void main() => runApp(const NavApp());
class NavApp extends StatelessWidget { const NavApp({super.key});
  @override Widget build(BuildContext context) =>
      const MaterialApp(home: HomeTabs());
}
class HomeTabs extends StatefulWidget { const HomeTabs({super.key});
  @override State<HomeTabs> createState() => _HomeTabsState();
}
class _HomeTabsState extends State<HomeTabs> {
  int index = 0;
  final screens = const [
    Center(child: Text('Home')),
    Center(child: Text('Search')),
    Center(child: Text('Profile')),
  ];
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie App')),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(()=> index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
