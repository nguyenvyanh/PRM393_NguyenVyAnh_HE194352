import 'package:flutter/material.dart';
void main() => runApp(const ListApp());

class ListApp extends StatelessWidget {
  const ListApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: Titles());
}

class Titles extends StatelessWidget {
  const Titles({super.key});
  @override
  Widget build(BuildContext context) {
    final items = const ['Godzilla x Kong','Dune: Part Two','The Batman','Oppenheimer'];
    return Scaffold(
      appBar: AppBar(title: const Text('ListView')),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) => ListTile(title: Text(items[i])),
      ),
    );
  }
}

