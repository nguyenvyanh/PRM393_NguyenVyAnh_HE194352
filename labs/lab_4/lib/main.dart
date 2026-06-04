import 'package:flutter/material.dart';

import 'screens/core_widgets_demo.dart';
import 'screens/input_controls_demo.dart';
import 'screens/layout_demo.dart';
import 'screens/theme_structure_demo.dart';
import 'screens/common_ui_fixes_demo.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatefulWidget {
  const Lab4App({super.key});

  @override
  State<Lab4App> createState() => _Lab4AppState();
}

class _Lab4AppState extends State<Lab4App> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter UI Fundamentals',
      debugShowCheckedModeBanner: false,

      // Light theme for the whole application.
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),

      // Dark theme for the whole application.
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),

      // The switch in Exercise 4 changes this value.
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: HomeScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final exercises = [
      ExerciseItem(
        title: 'Exercise 1 - Core Widgets Demo',
        subtitle: 'Text, Image, Icon, Card, ListTile',
        screen: const CoreWidgetsDemo(),
      ),
      ExerciseItem(
        title: 'Exercise 2 - Input Controls Demo',
        subtitle: 'Slider, Switch, RadioListTile, DatePicker',
        screen: const InputControlsDemo(),
      ),
      ExerciseItem(
        title: 'Exercise 3 - Layout Demo',
        subtitle: 'Column, Row, Padding, ListView',
        screen: const LayoutDemo(),
      ),
      ExerciseItem(
        title: 'Exercise 4 - App Structure & Theme',
        subtitle: 'Scaffold, AppBar, FAB, ThemeData',
        screen: ThemeStructureDemo(
          isDarkMode: isDarkMode,
          onThemeChanged: onThemeChanged,
        ),
      ),
      ExerciseItem(
        title: 'Exercise 5 - Common UI Fixes',
        subtitle: 'Expanded, ScrollView, setState, DatePicker context',
        screen: const CommonUiFixesDemo(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 - Flutter UI Fundamentals'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = exercises[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item.screen),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ExerciseItem {
  const ExerciseItem({
    required this.title,
    required this.subtitle,
    required this.screen,
  });

  final String title;
  final String subtitle;
  final Widget screen;
}
