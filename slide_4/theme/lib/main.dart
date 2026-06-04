import 'package:flutter/material.dart';
void main() => runApp(const ThemedApp());
class ThemedApp extends StatelessWidget { const ThemedApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark, // Try ThemeMode.dark to preview
      home: const DemoTheme(),
    );
}}
class DemoTheme extends StatelessWidget { const DemoTheme({super.key});
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Demo')),
      body: Center(
        child: Text('Current theme',
            style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}

