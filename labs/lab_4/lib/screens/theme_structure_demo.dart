import 'package:flutter/material.dart';

class ThemeStructureDemo extends StatelessWidget {
  const ThemeStructureDemo({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar is the top application bar.
      appBar: AppBar(
        title: const Text('Exercise 4 - App Structure'),
        actions: [
          Row(
            children: [
              const Text('Dark'),
              Switch(
                value: isDarkMode,

                // This callback is sent back to the root MaterialApp.
                onChanged: onThemeChanged,
              ),
            ],
          ),
        ],
      ),

      // Body is the main screen content.
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'This screen uses Scaffold, AppBar, Body, FloatingActionButton, '
                'ThemeData, and a Dark Mode toggle.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      ),

      // FloatingActionButton is a common Scaffold action button.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB clicked')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
