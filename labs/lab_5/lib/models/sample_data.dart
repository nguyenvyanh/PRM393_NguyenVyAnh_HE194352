import 'movie.dart';

const List<Movie> sampleMovies = [
  Movie(
    id: 1,
    title: 'Dune: Part Two',
    posterUrl: 'https://image.tmdb.org/t/p/w780/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
    overview:
        'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    trailers: [
      Trailer(title: 'Official Trailer #1', duration: '2:35'),
      Trailer(title: 'IMAX Sneak Peek', duration: '1:42'),
      Trailer(title: 'Final Trailer', duration: '2:12'),
    ],
  ),
  Movie(
    id: 2,
    title: 'Deadpool & Wolverine',
    posterUrl: 'https://image.tmdb.org/t/p/w780/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
    overview:
        'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    genres: ['Action', 'Comedy'],
    rating: 8.3,
    trailers: [
      Trailer(title: 'Red Band Trailer', duration: '2:25'),
      Trailer(title: 'Behind the Scenes', duration: '3:10'),
      Trailer(title: 'Final Trailer', duration: '2:01'),
    ],
  ),
  Movie(
    id: 3,
    title: 'Inside Out 2',
    posterUrl: 'https://image.tmdb.org/t/p/w780/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
    overview:
        'Riley enters her teenage years, and new emotions arrive to change everything inside her mind.',
    genres: ['Animation', 'Family', 'Comedy'],
    rating: 7.8,
    trailers: [
      Trailer(title: 'Official Trailer', duration: '2:24'),
      Trailer(title: 'Meet Anxiety', duration: '1:30'),
      Trailer(title: 'Sneak Peek', duration: '1:47'),
    ],
  ),
];
