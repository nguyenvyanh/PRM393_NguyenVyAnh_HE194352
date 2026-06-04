import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = [
      'Avatar',
      'Inception',
      'Interstellar',
      'Joker',
      'The Dark Knight',
      'Avengers',
      'Titanic',
      'Dune',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 - Layout Demo'),
      ),

      // Padding gives consistent outer spacing.
      body: Padding(
        padding: const EdgeInsets.all(16),

        // Column creates vertical sections.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 12),

            // Row creates a horizontal section.
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    icon: Icons.movie,
                    title: '${movies.length}',
                    subtitle: 'Movies',
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: _InfoCard(
                    icon: Icons.star,
                    title: '4.8',
                    subtitle: 'Rating',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              'Movie List',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 8),

            // Expanded fixes ListView inside Column by giving it available height.
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(movie[0]),
                      ),
                      title: Text(movie),
                      subtitle: const Text('Sample description'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                Text(subtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
