import 'package:flutter/material.dart';

class CommonUiFixesDemo extends StatefulWidget {
  const CommonUiFixesDemo({super.key});

  @override
  State<CommonUiFixesDemo> createState() => _CommonUiFixesDemoState();
}

class _CommonUiFixesDemoState extends State<CommonUiFixesDemo> {
  int counter = 0;
  DateTime? selectedDate;

  final movies = const [
    'Movie A',
    'Movie B',
    'Movie C',
    'Movie D',
    'Movie E',
  ];

  Future<void> pickDateSafely() async {
    // Correct: this context belongs to the current State object in the widget tree.
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = selectedDate == null
        ? 'No date selected'
        : selectedDate!.toLocal().toString().split(' ')[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 - Common UI Fixes'),
      ),

      // SingleChildScrollView prevents overflow on small screens.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        // ConstrainedBox gives a minimum height to make the inner layout stable.
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Correct ListView inside Column using SizedBox/Expanded',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 8),

              // Fix: ListView inside Column must have a bounded height.
              SizedBox(
                height: 260,
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.movie),
                      title: Text(movies[index]),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              Text(
                '2. Overflow fixed with SingleChildScrollView',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Text(
                'This page is scrollable, so it will not overflow on small screens.',
              ),

              const SizedBox(height: 16),

              Text(
                '3. State update fixed with setState()',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('Counter: $counter'),
              ElevatedButton(
                onPressed: () {
                  // Correct: setState rebuilds the UI after changing counter.
                  setState(() {
                    counter++;
                  });
                },
                child: const Text('Increase Counter'),
              ),

              const SizedBox(height: 16),

              Text(
                '4. DatePicker context fixed',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('Selected date: $dateText'),
              ElevatedButton.icon(
                onPressed: pickDateSafely,
                icon: const Icon(Icons.calendar_month),
                label: const Text('Pick Date Safely'),
              ),

              const SizedBox(height: 16),

              const Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Short explanation: Expanded/SizedBox fixes unbounded ListView height. '
                    'SingleChildScrollView fixes overflow. setState fixes UI not updating. '
                    'Calling DatePicker from a valid widget context fixes context errors.',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
