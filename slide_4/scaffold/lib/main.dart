import 'package:flutter/material.dart';
void main() => runApp(const ScaffoldDemoApp());

class ScaffoldDemoApp extends StatelessWidget {
  const ScaffoldDemoApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: FirstScreen());
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: const Center(child: Text('Hello Scaffold')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, child: const Icon(Icons.add),
      ),
    );
  }
}
