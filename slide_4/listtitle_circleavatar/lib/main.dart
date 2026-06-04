import 'package:flutter/material.dart';
void main() => runApp(const TileApp());

class TileApp extends StatelessWidget {
  const TileApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: TileList());
}

class TileList extends StatelessWidget {
  const TileList({super.key});
  @override
  Widget build(BuildContext context) {
    final movies = const [
      {'title':'Godzilla x Kong','year':'2024'},
      {'title':'Dune: Part Two','year':'2024'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('ListTile + Avatar')),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (_, i) {
          final m = movies[i];
          return ListTile(
            leading: CircleAvatar(child: Text(m['title']![0])),
            title: Text(m['title']!), subtitle: Text(m['year']!),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => debugPrint('Selected ${m['title']}'),
          );
        },
      ),
    );
  }
}

