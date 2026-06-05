class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final List<String> trailers;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.trailers,
  });
}

final List<Movie> movies = [
  Movie(
    id: 1,
    title: 'Avengers: Endgame',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
    overview:
        'After the devastating events of Infinity War, the Avengers assemble once more to reverse Thanos actions and restore balance to the universe.',
    genres: ['Action', 'Adventure', 'Sci-Fi'],
    trailers: ['Official Trailer', 'Final Battle Trailer', 'Behind The Scenes'],
  ),
  Movie(
    id: 2,
    title: 'Spider-Man: No Way Home',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
    overview:
        'Peter Parker asks Doctor Strange for help, but things go wrong and dangerous enemies from other worlds appear.',
    genres: ['Action', 'Fantasy', 'Adventure'],
    trailers: ['Official Trailer', 'Teaser Trailer', 'Multiverse Trailer'],
  ),
  Movie(
    id: 3,
    title: 'The Batman',
    posterUrl:
        'https://image.tmdb.org/t/p/w500/b0PlSFdDwbyK0cf5RxwDpaOJQvQ.jpg',
    overview:
        'Batman investigates corruption in Gotham City while facing a mysterious killer known as the Riddler.',
    genres: ['Crime', 'Drama', 'Action'],
    trailers: ['Main Trailer', 'Gotham Trailer', 'The Riddler Trailer'],
  ),
];