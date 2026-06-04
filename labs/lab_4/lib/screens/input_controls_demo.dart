import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double rating = 50;
  bool isActive = false;
  String? genre;
  DateTime? selectedDate;

  Future<void> pickDate() async {
    // showDatePicker must be called from a valid BuildContext inside the widget tree.
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // setState updates the value and rebuilds the UI.
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = selectedDate == null
        ? 'No date selected'
        : selectedDate!.toLocal().toString().split(' ')[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 - Input Controls'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rating (Slider)', style: Theme.of(context).textTheme.titleMedium),
            Slider(
              value: rating,
              min: 0,
              max: 100,
              divisions: 100,
              label: rating.round().toString(),

              // The slider value changes continuously while dragging.
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            Text('Current value: ${rating.round()}'),

            const SizedBox(height: 24),

            Text('Active (Switch)', style: Theme.of(context).textTheme.titleMedium),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Is movie active?'),
              value: isActive,

              // Switch updates a boolean value.
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              },
            ),
            Text('Active status: ${isActive ? "Yes" : "No"}'),

            const SizedBox(height: 24),

            Text('Genre (RadioListTile)', style: Theme.of(context).textTheme.titleMedium),
            RadioListTile<String>(
              title: const Text('Action'),
              value: 'Action',
              groupValue: genre,

              // Only one RadioListTile in the same group can be selected.
              onChanged: (value) {
                setState(() {
                  genre = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Comedy'),
              value: 'Comedy',
              groupValue: genre,
              onChanged: (value) {
                setState(() {
                  genre = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Drama'),
              value: 'Drama',
              groupValue: genre,
              onChanged: (value) {
                setState(() {
                  genre = value;
                });
              },
            ),
            Text('Selected genre: ${genre ?? "None"}'),

            const SizedBox(height: 24),

            Text('DatePicker', style: Theme.of(context).textTheme.titleMedium),
            Text('Selected date: $formattedDate'),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: pickDate,
                icon: const Icon(Icons.calendar_month),
                label: const Text('Open Date Picker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
