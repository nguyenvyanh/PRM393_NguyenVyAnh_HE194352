import 'package:flutter/material.dart';
void main() => runApp(const SwitchDemoApp());

class SwitchDemoApp extends StatelessWidget {
  const SwitchDemoApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: SwitchScreen());
}

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});
  @override State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Switch Example')),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Dark Mode'),
            Switch(value: isOn, onChanged: (v) => setState(() => isOn = v)),
          ],
        ),
      ),
    );
  }
}

