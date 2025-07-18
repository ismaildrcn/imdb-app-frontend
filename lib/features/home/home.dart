import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/data/services/constant/api_constants.dart';
import 'package:imdb_app/data/services/movie_service.dart';
import 'package:imdb_app/features/home/utils/image_utils.dart';
import 'package:imdb_app/features/home/widgets/movie_carousel.dart';

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
    setState(() {
      _allMovies = movies;
      _displayMovies = movies.sublist(0, 10);
    });
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
                  MovieCarousel(isMoviePage: false, movie: _allMovies[0]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.minimize,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Icon(
                        Icons.minimize,
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withAlpha(75),
                      ),
                      Icon(
                        Icons.minimize,
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withAlpha(75),
                      ),
                      Icon(
                        Icons.minimize,
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withAlpha(75),
                      ),
                    ],
                  ),
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
            height: 260,
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
    return GestureDetector(
      onTap: () {
        context.push("/movie/${movie.id}");
      },
      child: Column(
        children: [
          Container(
            width: 175,
            height: 230,
            margin: isApplyMargin ? const EdgeInsets.only(right: 20) : null,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: ImageHelper.getImage(
                  movie.posterPath,
                  ApiConstants.posterSize.m,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 175,
            child: Text(
              movie.originalTitle!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
