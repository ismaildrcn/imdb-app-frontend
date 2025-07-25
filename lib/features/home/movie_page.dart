import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/model/credits_model.dart';
import 'package:imdb_app/data/model/review_model.dart';
import 'package:imdb_app/data/services/credits_service.dart';
import 'package:imdb_app/data/services/constant/api_constants.dart';
import 'package:imdb_app/data/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/data/services/reviews_service.dart';
import 'package:imdb_app/features/home/utils/image_utils.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class MoviePage extends StatefulWidget {
  final int movieId;
  const MoviePage({super.key, required this.movieId});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late final MovieService _movieService;
  late final CreditsService _creditsService;
  late final ReviewsService _reviewsService;
  MovieModel? _movie;
  Credits? _credits;
  ReviewsModel? _reviews;

  @override
  void initState() {
    super.initState();
    _movieService = MovieService();
    _creditsService = CreditsService();
    _reviewsService = ReviewsService();
    loadData();
  }

  Future<void> loadData() async {
    final movie = await _movieService.fetchMovie(widget.movieId);
    final credits = await _creditsService.fetchCredits(widget.movieId);
    final reviews = await _reviewsService.fetchReviews(widget.movieId);
    setState(() {
      _movie = movie;
      _credits = credits;
      _reviews = reviews;
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
                      Row(
                        children: [
                          Text(
                            "Cast and Crew",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              context.push(AppRoutes.credits, extra: _credits);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                            ),
                            child: Text(
                              "See all",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
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
                                          _credits!.cast[index].profilePath,
                                          ApiConstants.posterSize.m,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    _credits!.cast[index].character,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    _credits!.cast[index].originalName,
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
                      SizedBox(height: 18),
                      _reviewsContainer(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _reviewsContainer() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Comments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Colors.transparent),
              child: Text(
                "See all",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
        SizedBox(
          height: 150,
          child: ListView.builder(
            itemCount: _reviews?.reviews.sublist(0, 3).length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _reviewCard(
                hasLastComment: index == 2,
                review: _reviews!.reviews[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _reviewCard({bool hasLastComment = false, Review? review}) {
    return Container(
      width: 300,
      constraints: BoxConstraints(minHeight: 100),
      margin: hasLastComment ? null : EdgeInsets.only(right: 20),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.secondary.withAlpha(32), // Gölge rengi ve opaklık
            blurRadius: 5, // Gölge yumuşaklığı
            spreadRadius: 1, // Gölge yayılması
            offset: Offset(0, 0), // Gölge pozisyonu (x, y)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: review!.authorDetails!.avatarPath != null
                    ? ImageHelper.getImage(
                        review.authorDetails!.avatarPath,
                        ApiConstants.posterSize.m,
                      )
                    : null,
                child: review.authorDetails!.avatarPath == null
                    ? Icon(Icons.person_rounded)
                    : null,
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    review!.authorDetails!.name == ""
                        ? "Anonymous"
                        : review.authorDetails!.name.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "June 12, 2023",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Text(review.authorDetails!.rating.toString()),
                  Icon(Icons.star_rate_rounded, color: Colors.amber),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            review.content.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
