import 'package:flutter/material.dart';

import 'json_crud_database_screen.dart';
import 'read_json_from_assets_screen.dart';
import 'save_load_json_storage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ReadJsonFromAssetsScreen(),
    SaveLoadJsonStorageScreen(),
    JsonCrudDatabaseScreen(),
  ];

  final List<String> _titles = const [
    'Lab 9.1 - Read Assets JSON',
    'Lab 9.2 - Save & Load JSON',
    'Lab 9.3 - CRUD JSON DB',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.folder_open),
            label: 'Assets',
          ),
          NavigationDestination(
            icon: Icon(Icons.save),
            label: 'Storage',
          ),
          NavigationDestination(
            icon: Icon(Icons.storage),
            label: 'CRUD',
          ),
        ],
      ),
    );
  }
}
