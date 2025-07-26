import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/data/services/constant/api_constants.dart';
import 'package:imdb_app/data/services/movie_service.dart';
import 'package:imdb_app/features/home/utils/image_utils.dart';
import 'package:imdb_app/features/home/widgets/movie_carousel.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static List<String> top10movies = [
    "The Godfather",
    "The Shawshank Redemption",
    "The Godfather Part II",
    "Inception",
    "Fight Club",
    "The Dark Knight",
    "12 Angry Men",
    "The Lord of the Rings: The Fellowship of the Ring",
    "The Matrix",
    "Se7en",
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MovieService _movieService;
  List<MovieModel> _allMovies = [];
  List<MovieModel> _displayMovies = [];

  @override
  void initState() {
    super.initState();
    _movieService = MovieService();
    loadData();
  }

  Future<void> loadData() async {
    final movies = await _movieService.fetchMovies();
    if (mounted) {
      setState(() {
        _allMovies = movies;
        _displayMovies = movies.sublist(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, null),
      body: SafeArea(
        child: _allMovies.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  MovieCarousel(movies: _allMovies.sublist(0, 3)),
                  SizedBox(height: 12),
                  HorizontalMoviesCardList(
                    allMovies: _allMovies,
                    displayMovies: _displayMovies,
                    title: "Top 10 Movies for you",
                  ),
                ],
              ),
      ),
    );
  }
}

class HorizontalMoviesCardList extends StatelessWidget {
  final List<MovieModel> allMovies;
  final List<MovieModel> displayMovies;
  final String title;
  const HorizontalMoviesCardList({
    super.key,
    required this.title,
    required this.allMovies,
    required this.displayMovies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push(AppRoutes.mostPopularMovies, extra: allMovies);
                },
                child: const Text("See More"),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: displayMovies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: displayMovies[index],
                  index: index,
                  isApplyMargin: displayMovies.length - 1 != index
                      ? true
                      : false,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final int index;
  final bool isApplyMargin;
  const MovieCard({
    super.key,
    required this.movie,
    required this.index,
    required this.isApplyMargin,
  });

  @override
  Widget build(BuildContext context) {
    double? voteAverage;
    voteAverage = movie.voteAverage! / 2;
    return GestureDetector(
      onTap: () {
        context.push("/movie/${movie.id}");
      },
      child: Container(
        margin: isApplyMargin ? const EdgeInsets.only(right: 20) : null,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 175,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSecondary.withAlpha(25),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: ImageHelper.getImage(
                        movie.posterPath,
                        ApiConstants.posterSize.m,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 6,
                        ),
                        color: Colors.white.withAlpha(48),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.star_rate_rounded, color: Colors.amber),
                            SizedBox(width: 4),
                            Text(
                              voteAverage.toStringAsFixed(1),
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 175,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    Text(
                      movie.originalTitle!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      DateFormat("yyyy").format(movie.releaseDate!),
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondary.withAlpha(128),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
