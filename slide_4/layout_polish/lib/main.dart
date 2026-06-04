import 'package:flutter/material.dart';
void main() => runApp(const PolishApp());

class PolishApp extends StatelessWidget {
  const PolishApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: Polish());
}

class Polish extends StatelessWidget {
  const Polish({super.key});

  Widget tile(String t, String s) => Card(
    margin: const EdgeInsets.symmetric(vertical: 6),
    child: ListTile(title: Text(t), subtitle: Text(s)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout Polish')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            tile('Spacing matters', 'Use padding/margin'),
            const SizedBox(height: 8),
            tile('Consistency', 'Use the same spacing scale'),
          ],
        ),
      ),
    );
  }
}
