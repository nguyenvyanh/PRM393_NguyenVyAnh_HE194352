import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/movie.dart';
import 'providers/favorite_provider.dart';
import 'screens/home_page.dart';
import 'screens/movie_detail_page.dart';
import 'screens/favorite_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoriteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    // Deep link dạng: /movie?id=1
    if (uri.path == '/movie') {
      final idString = uri.queryParameters['id'];
      final movieId = int.tryParse(idString ?? '');

      final movie = movies.firstWhere(
        (item) => item.id == movieId,
        orElse: () => movies.first,
      );

      return MaterialPageRoute(
        builder: (_) => MovieDetailPage(movie: movie),
      );
    }

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/favorites':
        return MaterialPageRoute(builder: (_) => const FavoritePage());

      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
    );
  }
}