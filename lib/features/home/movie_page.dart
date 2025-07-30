import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/model/credits_model.dart';
import 'package:imdb_app/data/model/review_model.dart';
import 'package:imdb_app/data/model/video_model.dart';
import 'package:imdb_app/data/services/credits_service.dart';
import 'package:imdb_app/data/services/constant/api_constants.dart';
import 'package:imdb_app/data/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/data/services/reviews_service.dart';
import 'package:imdb_app/data/services/video_service.dart';
import 'package:imdb_app/features/home/utils/image_utils.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePage extends StatefulWidget {
  final int movieId;
  final bool? hasVideo;
  const MoviePage({super.key, required this.movieId, this.hasVideo});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late final MovieService _movieService;
  late final CreditsService _creditsService;
  late final ReviewsService _reviewsService;
  late final VideoService _videoService;
  late final YoutubePlayerController _youtubePlayerController;
  MovieModel? _movie;
  Credits? _credits;
  ReviewsModel? _reviews;
  Videos? _videos;
  double? voteAverage;
  Future<void>? _loadDataFuture; // Nullable Future tanımla

  @override
  void initState() {
    super.initState();
    _movieService = MovieService();
    _creditsService = CreditsService();
    _reviewsService = ReviewsService();
    _videoService = VideoService();
    _loadDataFuture = loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _loadDataFuture?.ignore();
    _youtubePlayerController.dispose();
  }

  Future<void> loadData() async {
    final movie = await _movieService.fetchMovie(widget.movieId);
    final credits = await _creditsService.fetchCredits(widget.movieId);
    final reviews = await _reviewsService.fetchReviews(widget.movieId);
    if (widget.hasVideo == true) {
      final videos = await _videoService.fetchVideos(widget.movieId);
      _videos = videos;
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: _videos!.results[0].key ?? '',
        flags: YoutubePlayerFlags(autoPlay: false),
      );
    }
    setState(() {
      _movie = movie;
      _credits = credits;
      _reviews = reviews;

      voteAverage = _movie!.voteAverage! / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _movie == null
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
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
                                Theme.of(
                                  context,
                                ).colorScheme.surface.withAlpha(255),
                                // Colors.transparent, // Üst kısım
                                Theme.of(
                                  context,
                                ).colorScheme.surface.withAlpha(150),
                                Theme.of(
                                  context,
                                ).colorScheme.surface.withAlpha(255),
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
                            spacing: 10,
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
                              Expanded(
                                child: Text(
                                  _movie!.originalTitle!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
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
                        top: 108,
                        bottom: 80,
                        left: 85,
                        right: 85,
                        child: Container(
                          width: 205,
                          height: 287,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: ImageHelper.getImage(
                                _movie!.posterPath,
                                ApiConstants.posterSize.original,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 5,
                        left: 20,
                        right: 20,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.grey[500],
                                    size: 24,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    DateFormat(
                                      "yyyy",
                                    ).format(_movie!.releaseDate!),
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 15,
                                    decoration: BoxDecoration(
                                      border: BoxBorder.fromBorderSide(
                                        BorderSide(
                                          color: Colors.grey,
                                          width: 0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.grey[500],
                                    size: 24,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${_movie!.runtime!.toString()} Minutes",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 15,
                                    decoration: BoxDecoration(
                                      border: BoxBorder.fromBorderSide(
                                        BorderSide(
                                          color: Colors.grey,
                                          width: 0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.movie_creation_outlined,
                                    color: Colors.grey[500],
                                    size: 24,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    _movie!.genres![0].name,
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    voteAverage!.toStringAsFixed(1),
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Video
                if (widget.hasVideo == true)
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 18),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        color: Colors.black, // opsiyonel: arka plan rengi
                        child: YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _youtubePlayerController,
                          ),
                          builder: (context, player) {
                            return Column(children: [player]);
                          },
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Text(
                        "Story Line",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
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
              onPressed: () => context.push("/reviews/${widget.movieId}"),
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
          height: _reviews!.reviews.isEmpty ? 0 : 150,
          child: ListView.builder(
            itemCount: _reviews!.reviews.length >= 3
                ? _reviews?.reviews.sublist(0, 3).length
                : _reviews?.reviews.length,
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
                    review.authorDetails!.name == ""
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
