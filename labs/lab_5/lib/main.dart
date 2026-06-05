import 'package:flutter/material.dart';

import 'models/movie.dart';
import 'models/sample_data.dart';
import 'screens/home_screen.dart';
import 'screens/movie_detail_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Detail App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF8F6FB),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == MovieDetailScreen.routeName) {
          final movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movie: movie),
          );
        }

        // Optional deep-link style route: /movie?id=2
        final uri = Uri.parse(settings.name ?? '');
        if (uri.path == '/movie') {
          final id = int.tryParse(uri.queryParameters['id'] ?? '');
          final movie = sampleMovies.firstWhere(
            (item) => item.id == id,
            orElse: () => sampleMovies.first,
          );
          return MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movie: movie),
          );
        }

        return MaterialPageRoute(builder: (_) => const HomeScreen());
      },
    );
  }
}
