import 'package:flutter/material.dart';
void main() => runApp(const SliderDemoApp());

class SliderDemoApp extends StatelessWidget {
  const SliderDemoApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: SliderScreen());
}

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});
  @override State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  double value = 0.5; // Range: 0..1
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: value,
            onChanged: (v) => setState(() => value = v),
          ),
          Text('Value: ${value.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}

