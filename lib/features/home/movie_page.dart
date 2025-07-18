import 'package:imdb_app/data/services/constant/api_constants.dart';
import 'package:imdb_app/data/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/features/home/utils/image_utils.dart';

class MoviePage extends StatefulWidget {
  final int movieId;
  const MoviePage({super.key, required this.movieId});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late final MovieService _movieService;
  MovieModel? _movie;

  @override
  void initState() {
    super.initState();
    _movieService = MovieService();
    loadData();
  }

  Future<void> loadData() async {
    final movie = await _movieService.fetchMovie(widget.movieId);
    setState(() {
      _movie = movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _movie == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondary.withAlpha(25),
                          image: DecorationImage(
                            image: ImageHelper.getImage(
                              _movie!.posterPath,
                              ApiConstants.posterSize.original,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Gradient Overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Theme.of(context).colorScheme.surface.withAlpha(
                                  255,
                                ), // Alt kısım
                                Colors.transparent, // Üst kısım
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "IMDB",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withAlpha(192),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      _movie!.voteAverage!.toStringAsFixed(1),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                            .withAlpha(192),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "(${_movie!.voteCount.toString()} Reviews)",
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary.withAlpha(192),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie Title Area
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          _movie!.originalTitle!,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          _movie!.tagline!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Row(
                        spacing: 10,
                        children: [
                          Text(
                            _movie!.releaseDate!,
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text("•"),
                          Text(_movie!.originCountry!.first),
                          const Text("•"),
                          Text(
                            "${_movie!.runtime!.toString()} minutes",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Movie Genres
                      SizedBox(
                        width: double.infinity,
                        height: 35,
                        child: ListView.builder(
                          itemCount: _movie!.genres!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              margin: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSecondary.withAlpha(64),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  _movie!.genres![index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(_movie!.overview!, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
