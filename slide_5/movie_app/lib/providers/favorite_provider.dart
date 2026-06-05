import 'package:flutter/material.dart';
import '../models/movie.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Movie> _favorites = [];

  List<Movie> get favorites => _favorites;

  bool isFavorite(Movie movie) {
    return _favorites.any((item) => item.id == movie.id);
  }

  void toggleFavorite(Movie movie) {
    if (isFavorite(movie)) {
      _favorites.removeWhere((item) => item.id == movie.id);
    } else {
      _favorites.add(movie);
    }

    notifyListeners();
  }
}