import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:imdb_app/data/datasources/local.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/data/repository/movie_repository.dart';
import 'package:imdb_app/features/home/widgets/movie_carousel.dart';

class MoviePage extends StatefulWidget {
  final String movieId;
  const MoviePage({super.key, required this.movieId});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late final MovieRepository _repository;
  MovieModel? _movie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository = MovieRepository(MovieLocalDataSource());
    loadData();
  }

  Future<void> loadData() async {
    final movie = await _repository.fetchMovie();
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
              spacing: 18,
              children: [
                MovieCarousel(isMoviePage: true, movie: _movie!),
                _movieReview(context),
                _movieActions(context),
                _movieDetails(context),
                _movieNavigationButtons(context),
              ],
            ),
    );
  }

  Padding _movieNavigationButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 90,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondary.withAlpha(25),
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Rating"),
            ),
          ),
          SizedBox(
            width: 90,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondary.withAlpha(25),
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Guide"),
            ),
          ),
          SizedBox(
            width: 90,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondary.withAlpha(25),
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Awards"),
            ),
          ),
          SizedBox(
            width: 90,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondary.withAlpha(25),
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Cast"),
            ),
          ),
        ],
      ),
    );
  }

  Padding _movieActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        spacing: 20,
        children: [
          Expanded(
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 12),
                  Text("Watch List"),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.alarm_add),
                  SizedBox(width: 12),
                  Text("Set Reminder"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _movieReview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rating & Review", style: TextStyle(fontSize: 16)),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 24,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 205,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(child: Text("J")),
                            Text("Jane Alexendre"),
                          ],
                        ),
                        Text(
                          "Promising",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Carrying the nostalgia of Game of thrones into this and comparing everything with the original...i would say this looks pretty awesome and you get the feel of watching original game of thrones... its the same but different characters...",
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(child: Text("A")),
                            Text("Jane Alexendre"),
                          ],
                        ),
                        Text(
                          "Promising",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Carrying the nostalgia of Game of thrones into this and comparing everything with the original...i would say this looks pretty awesome and you get the feel of watching original game of thrones... its the same but different characters...",
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _movieDetails(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Release date"),
          subtitle: Text(
            _movie!.releaseDate != null
                ? DateFormat('dd MMM yyyy').format(_movie!.releaseDate!)
                : "Unknown",
          ),
        ),
        ListTile(
          title: Text("Creators:"),
          subtitle: Text(_movie!.directors!.map((e) => e.fullName).join(", ")),
        ),
        ListTile(
          title: Text("Stars:"),
          subtitle: Text(_movie!.cast!.map((e) => e.fullName).join(", ")),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).colorScheme.secondary,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
