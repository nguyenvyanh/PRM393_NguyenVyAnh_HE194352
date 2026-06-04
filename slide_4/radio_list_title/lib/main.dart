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
            title: const Text('PRM'),
            value: 'PRM',
            groupValue: quality,
            onChanged: (v) => setState(() => quality = v),
          ),
          RadioListTile<String>(
            title: const Text('PRN'),
            value: 'PRN',
            groupValue: quality,
            onChanged: (v) => setState(() => quality = v),
          ),
          RadioListTile<String>(
            title: const Text('MLN'),
            value: 'MLN',
            groupValue: quality,
            onChanged: (v) => setState(() => quality = v),
          ),
        ],
      ),
    );
  }
}

