import 'package:flutter/material.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/data/services/movie_service.dart';
import 'package:imdb_app/features/home/widgets/movie_list_card.dart';

class MoviesPage extends StatefulWidget {
  final String title;
  final List<MovieModel> allMovies;
  const MoviesPage({super.key, required this.allMovies, required this.title});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  bool isLoading = true;
  late final MovieService _movieService;
  List<MovieModel> movies = [];
  int movieCount = 0;

  @override
  void initState() {
    super.initState();
    _movieService = MovieService();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    final movies = await Future.wait(
      widget.allMovies.take(5).map((e) {
        movieCount++;
        return _movieService.fetchMovie(e.id);
      }),
    );
    setState(() {
      this.movies = movies;
      isLoading = false;
    });
  }

  Future<void> loadMoreData() async {
    final moreMovies = await Future.wait(
      widget.allMovies.skip(movieCount).take(5).map((e) {
        movieCount++;
        return _movieService.fetchMovie(e.id);
      }),
    );
    setState(() {
      movies.addAll(moreMovies);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, widget.title),
      body: NotificationListener(
        onNotification: (notification) {
          // Listenin sonuna gelindiğinde yeni veri çek
          if (notification is ScrollEndNotification &&
              notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - 200) {
            loadMoreData();
          }
          return true;
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsetsGeometry.all(18),
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieListCard(movie: movies[index]);
                  },
                ),
              ),
      ),
    );
  }
}
