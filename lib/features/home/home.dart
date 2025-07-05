import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/datasources/local.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/data/repository/movie_repository.dart';
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
  late final MovieRepository _repository;
  List<MovieModel> _allMovies = [];
  List<MovieModel> _displayMovies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository = MovieRepository(
      MovieLocalDataSource(),
    );
    loadData();
  }

  Future<void> loadData() async {
    final movies = await _repository.fetchMovies();
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
        child: ListView(
          children: [
            MovieCarousel(isMoviePage: false),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.minimize,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Icon(
                  Icons.minimize,
                  color: Theme.of(context).colorScheme.secondary.withAlpha(75),
                ),
                Icon(
                  Icons.minimize,
                  color: Theme.of(context).colorScheme.secondary.withAlpha(75),
                ),
                Icon(
                  Icons.minimize,
                  color: Theme.of(context).colorScheme.secondary.withAlpha(75),
                ),
              ],
            ),
            SizedBox(height: 12),
            HorizontalMoviesCardList(
              allMovies: _allMovies,
              displayMovies: _displayMovies,
              title: "Top 10 Movies for you",
            ),
            SizedBox(height: 16),
            // HorizontalMoviesCardList(
            //   movies: HomePage.top10movies,
            //   title: "Upcoming Movies",
            // ),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  context.push(AppRoutes.mostPopularMovies, extra: allMovies);
                },
                child: Text("See More"),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 193,
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
            width: 130,
            height: 160,
            margin: isApplyMargin ? EdgeInsets.only(right: 16) : null,
            decoration: BoxDecoration(
              color: Colors.primaries[index % Colors.primaries.length],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: (movie.primaryImage != null)
                    ? NetworkImage(movie.primaryImage!)
                    : AssetImage("assets/img/no-image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: 130,
            child: Text(
              movie.originalTitle!,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
