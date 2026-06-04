import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 - Core Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        // Column creates a vertical layout.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text widget displays a headline.
            Text(
              'Welcome to Flutter UI',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 16),

            // Icon widget uses Material Icons.
            const Icon(
              Icons.movie_creation,
              size: 72,
            ),

            const SizedBox(height: 16),

            // Image.network displays an image from the internet.
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://picsum.photos/600/300',
                height: 180,
                fit: BoxFit.cover,

                // Error UI appears if the image cannot be loaded.
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    alignment: Alignment.center,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Text('Image failed to load'),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Card creates a Material container with elevation and rounded corners.
            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Movie Item'),
                subtitle: const Text('This is a sample ListTile inside a Card.'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
