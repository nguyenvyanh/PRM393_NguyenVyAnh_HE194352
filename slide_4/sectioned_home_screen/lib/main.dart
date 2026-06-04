import 'package:flutter/material.dart';
void main() => runApp(const SectionsApp());
class SectionsApp extends StatelessWidget { const SectionsApp({super.key});
  @override Widget build(BuildContext context) =>
      const MaterialApp(home: SectionsHome());
}
class SectionsHome extends StatelessWidget { const SectionsHome({super.key});
  Widget section(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        TextButton(onPressed: (){}, child: const Text('See all')),
      ],
    ),
  );
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          section('Now Playing'), const Placeholder(fallbackHeight: 120),
          section('Trending'), const Placeholder(fallbackHeight: 120),
          section('Popular'), const Placeholder(fallbackHeight: 120),
          section('Top Rated'), const Placeholder(fallbackHeight: 120),
        ],
      ),
    );
  }
}

