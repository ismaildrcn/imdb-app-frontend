import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/model/movie/movie_model.dart';
import 'package:imdb_app/data/services/constant/api_constants.dart';
import 'package:imdb_app/data/services/movie_service.dart';
import 'package:imdb_app/features/home/utils/image_utils.dart';
import 'package:imdb_app/features/home/widgets/movie_carousel.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MovieService _movieService;
  List<MovieModel> _topRatedMovies = [];
  List<MovieModel> _nowPlayingMovies = [];
  List<MovieModel> _upComingMovies = [];

  @override
  void initState() {
    super.initState();
    _movieService = MovieService();
    loadData();
  }

  Future<void> loadData() async {
    final topRated = await _movieService.fetchMovies(type: MovieTypes.topRated);
    final nowPlaying = await _movieService.fetchMovies(
      type: MovieTypes.nowPlaying,
    );
    final upcoming = await _movieService.fetchMovies(type: MovieTypes.upcoming);
    if (mounted) {
      setState(() {
        _topRatedMovies = topRated;
        _nowPlayingMovies = nowPlaying;
        _upComingMovies = upcoming;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: topNavBar(context, null),
      body: SafeArea(
        child: _topRatedMovies.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  children: [
                    _topBar(context),
                    MovieCarousel(movies: _topRatedMovies.sublist(0, 3)),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          HorizontalMoviesCardList(
                            allMovies: _topRatedMovies,
                            displayMovies: _topRatedMovies.sublist(0, 5),
                            title: "Most Popular",
                          ),
                          HorizontalMoviesCardList(
                            allMovies: _nowPlayingMovies,
                            displayMovies: _nowPlayingMovies.sublist(0, 5),
                            title: "Now Playing",
                          ),
                          HorizontalMoviesCardList(
                            allMovies: _upComingMovies,
                            displayMovies: _upComingMovies.sublist(0, 5),
                            title: "Upcoming",
                            route: AppRoutes.upcoming,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      height: 78,
      child: Row(
        spacing: 16,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/img/ismail-durcan.jpg"),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                "Hello, İsmail",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Let’s stream your favorite movie",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.favorite, color: Colors.red[800], size: 24),
          ),
        ],
      ),
    );
  }
}

class HorizontalMoviesCardList extends StatelessWidget {
  final List<MovieModel> allMovies;
  final List<MovieModel> displayMovies;
  final String title;
  final String? route;
  const HorizontalMoviesCardList({
    super.key,
    required this.title,
    required this.allMovies,
    required this.displayMovies,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                context.push(
                  route ?? AppRoutes.movies,
                  extra: route != null
                      ? allMovies
                      : <String, dynamic>{
                          "allMovies": allMovies,
                          "title": title,
                        },
                );
              },
              child: const Text("See More"),
            ),
          ],
        ),
        MovieCard(displayMovies: displayMovies),
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.displayMovies});

  final List<MovieModel> displayMovies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemCount: displayMovies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          MovieModel movie = displayMovies[index];
          double? voteAverage;
          voteAverage = movie.voteAverage! / 2;
          return GestureDetector(
            onTap: () {
              context.push("/movie/${movie.id}");
            },
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
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                ),
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
          );
        },
      ),
    );
  }
}
