import 'package:flutter/material.dart';
void main() => runApp(const TimePickerDemoApp());

class TimePickerDemoApp extends StatelessWidget {
  const TimePickerDemoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Time Picker')),
      body: const TimePickerDemo(),
    ),
  );
}

class TimePickerDemo extends StatefulWidget {
  const TimePickerDemo({super.key});
  @override State<TimePickerDemo> createState() => _TimePickerDemoState();
}

class _TimePickerDemoState extends State<TimePickerDemo> {
  TimeOfDay? selected;
  Future<void> pick() async {
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (t != null) setState(() => selected = t);
  }

  @override
  Widget build(BuildContext context) {
    final text = selected == null ? 'No time' : 'Selected: ${selected!.format(context)}';
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(text, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: pick, child: const Text('Pick Time')),
      ]),
    );
  }
}
