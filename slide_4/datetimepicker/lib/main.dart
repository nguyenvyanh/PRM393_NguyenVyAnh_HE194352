import 'package:flutter/material.dart';
void main() => runApp(const BookingApp());

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: Booking());
}

class Booking extends StatefulWidget {
  const Booking({super.key});
  @override State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? d; TimeOfDay? t;

  Future<void> pickDate() async {
    final x = await showDatePicker(
      context: context, initialDate: DateTime.now(),
      firstDate: DateTime(2020), lastDate: DateTime(2100));
    if (x != null) setState(()=> d = x);
  }

  Future<void> pickTime() async {
    final x = await showTimePicker(
      context: context, initialTime: TimeOfDay.now());
    if (x != null) setState(()=> t = x);
  }

  @override
  Widget build(BuildContext context) {
    final dateText = d == null ? 'No date' : '${d!.year}-${d!.month}-${d!.day}';
    final timeText = t == null ? 'No time' : t!.format(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Booking')),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Date: $dateText'), const SizedBox(height: 8),
          Text('Time: $timeText'), const SizedBox(height: 16),
          ElevatedButton(onPressed: pickDate, child: const Text('Pick Date')),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: pickTime, child: const Text('Pick Time')),
        ],
      )),
    );
  }
}
