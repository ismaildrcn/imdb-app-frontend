import 'package:go_router/go_router.dart';
import 'package:imdb_app/data/model/cast_model.dart';
import 'package:imdb_app/data/services/cast_service.dart';
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
  late final CastService _castService;
  MovieModel? _movie;
  List<CastModel>? _cast;

  @override
  void initState() {
    super.initState();
    _movieService = MovieService();
    _castService = CastService();
    loadData();
  }

  Future<void> loadData() async {
    final movie = await _movieService.fetchMovie(widget.movieId);
    final cast = await _castService.fetchCast(widget.movieId);
    setState(() {
      _movie = movie;
      _cast = cast;
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

                      // Top Action Button
                      Positioned(
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 18,
                            right: 18,
                            top: 55,
                          ),
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => context.pop(),
                                child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface.withAlpha(64),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 30,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface.withAlpha(64),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Icon(Icons.bookmark_border, size: 30),
                                ),
                              ),
                            ],
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
                                margin: EdgeInsets.only(
                                  left: 18,
                                  right: 18,
                                  bottom: 10,
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
                                        fontSize: 18,
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "(${_movie!.voteCount.toString()} Reviews)",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary.withAlpha(192),
                                    fontSize: 18,
                                  ),
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
                          Icon(Icons.calendar_month_outlined, size: 18),
                          Text(
                            _movie!.releaseDate!,
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text("•"),
                          Icon(Icons.location_on_outlined, size: 18),
                          Text(_movie!.originCountry!.first),
                          const Text("•"),
                          Icon(Icons.access_time, size: 18),
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
                      const SizedBox(height: 20),

                      // Cast
                      Text(
                        "Top Cast",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 20),
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: ImageHelper.getImage(
                                          _cast![index].profilePath,
                                          ApiConstants.posterSize.m,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    _cast![index].character,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    _cast![index].originalName,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary.withAlpha(128),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
