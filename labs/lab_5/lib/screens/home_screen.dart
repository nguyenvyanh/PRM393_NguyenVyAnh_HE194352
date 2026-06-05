import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/sample_data.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String keyword = '';

  List<Movie> get filteredMovies {
    return sampleMovies.where((movie) {
      final lowerKeyword = keyword.toLowerCase();
      final titleMatch = movie.title.toLowerCase().contains(lowerKeyword);
      final genreMatch = movie.genres.join(' ').toLowerCase().contains(lowerKeyword);
      return titleMatch || genreMatch;
    }).toList();
  }

  void openMovieDetail(Movie movie) {
    Navigator.pushNamed(
      context,
      MovieDetailScreen.routeName,
      arguments: movie,
    );
  }

  void openDeepLinkDemo() {
    Navigator.pushNamed(context, '/movie?id=2');
  }

  @override
  Widget build(BuildContext context) {
    final movies = filteredMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            tooltip: 'Deep link demo',
            onPressed: openDeepLinkDemo,
            icon: const Icon(Icons.link),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: (value) => setState(() => keyword = value),
              decoration: InputDecoration(
                hintText: 'Search movie or genre...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: movies.isEmpty
                ? const Center(child: Text('No movies found'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieCard(
                        movie: movie,
                        onTap: () => openMovieDetail(movie),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: 'poster_${movie.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    movie.posterUrl,
                    width: 96,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 96,
                      height: 72,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.movie),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '★ ${movie.rating} · ${movie.genres.join(', ')}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
