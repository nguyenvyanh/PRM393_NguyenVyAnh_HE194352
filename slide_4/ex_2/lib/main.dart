import 'package:flutter/material.dart';
void main() => runApp(const RadioDemoApp());

class RadioDemoApp extends StatelessWidget {
  const RadioDemoApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: RadioScreen());
}

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});
  @override State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  String? quality = 'HD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RadioListTile')),
      body: Column(
        children: [
          RadioListTile<String>(
            title: const Text('SD'),
            value: 'SD',
            groupValue: quality,
            onChanged: (v) => setState(() => quality = v),
          ),
          RadioListTile<String>(
            title: const Text('HD'),
            value: 'HD',
            groupValue: quality,
            onChanged: (v) => setState(() => quality = v),
          ),
          RadioListTile<String>(
            title: const Text('4K'),
            value: '4K',
            groupValue: quality,
            onChanged: (v) => setState(() => quality = v),
          ),
        ],
      ),
    );
  }
}

