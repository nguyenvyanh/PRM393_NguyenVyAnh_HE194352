import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String routeName = '/detail';

  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;
  int selectedRating = 0;

  void toggleFavorite() {
    setState(() => isFavorite = !isFavorite);
  }

  void rateMovie() {
    setState(() {
      selectedRating = selectedRating == 5 ? 0 : selectedRating + 1;
    });
  }

  void shareMovie() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Share ${widget.movie.title}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 290,
            pinned: true,
            title: Text(movie.title),
            flexibleSpace: FlexibleSpaceBar(
              background: HeroBanner(movie: movie),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: movie.genres
                        .map((genre) => Chip(label: Text(genre)))
                        .toList(),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Rating: ★ ${movie.rating}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionButton(
                        icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                        label: isFavorite ? 'Liked' : 'Favorite',
                        onPressed: toggleFavorite,
                      ),
                      ActionButton(
                        icon: Icons.star_rate,
                        label: selectedRating == 0 ? 'Rate' : '$selectedRating/5',
                        onPressed: rateMovie,
                      ),
                      ActionButton(
                        icon: Icons.share,
                        label: 'Share',
                        onPressed: shareMovie,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Trailers',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    itemCount: movie.trailers.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final trailer = movie.trailers[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.play_circle_fill),
                          title: Text(trailer.title),
                          subtitle: Text(trailer.duration),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Play ${trailer.title}')),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroBanner extends StatelessWidget {
  final Movie movie;

  const HeroBanner({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: 'poster_${movie.id}',
          child: Image.network(
            movie.posterUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey.shade300,
              child: const Icon(Icons.movie, size: 80),
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.05),
                Colors.black.withOpacity(0.85),
              ],
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 18,
          child: Text(
            movie.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton.filledTonal(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
