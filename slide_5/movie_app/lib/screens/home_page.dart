import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openDetail(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailPage(movie: movie),
      ),
    );
  }

  void openDeepLinkExample(BuildContext context) {
    Navigator.pushNamed(context, '/movie?id=2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12),
            child: ElevatedButton.icon(
              onPressed: () => openDeepLinkExample(context),
              icon: const Icon(Icons.link),
              label: const Text('Open Deep Link: /movie?id=2'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        movie.posterUrl,
                        width: 55,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      movie.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(movie.genres.join(', ')),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => openDetail(context, movie),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}