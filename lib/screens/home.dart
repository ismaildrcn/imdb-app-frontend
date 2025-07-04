import 'package:flutter/material.dart';
import 'package:imdb_app/data/datasources/local.dart';
import 'package:imdb_app/data/model/most_popular_movies_model.dart';
import 'package:imdb_app/data/repository/movie_repository.dart';

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
  late final MostPopuplarMoviesRepository _repository;
  List<MostPopularMoviesModel> _movieList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository = MostPopuplarMoviesRepository(MostPopularMoviesLocalDataSource());
    loadData();
  }

  Future<void> loadData() async {
    final movies = await _repository.fetchMovies();
    setState(() {
      _movieList = movies.sublist(0, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            MovieCarousel(),
            SizedBox(height: 12),
            HorizontalMoviesCardList(
              movies: _movieList,
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

class MovieCarousel extends StatelessWidget {
  const MovieCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/img/rectangle.png",
                  fit: BoxFit.cover,
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
                        Colors.black.withAlpha(255), // Alt kısım
                        Colors.transparent, // Üst kısım
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                    vertical: 13,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "House of the Dragon",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "An internal succession war within House Targaryen at the height of its power, 172 years before the birth of Daenerys Targaryen.",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("See More"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.minimize, color: Theme.of(context).colorScheme.primary),
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
      ],
    );
  }
}

class HorizontalMoviesCardList extends StatelessWidget {
  final List<MostPopularMoviesModel> movies;
  final String title;
  const HorizontalMoviesCardList({
    super.key,
    required this.movies,
    required this.title,
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
              TextButton(onPressed: () {}, child: Text("See More")),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 193,
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: 130,
                      height: 160,
                      margin: EdgeInsets.only(
                        right: movies.length - 1 != index ? 16 : 0,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: (movies[index].primaryImage != null)
                              ? NetworkImage(movies[index].primaryImage!)
                              : AssetImage("assets/img/no-image.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: 130,
                      child: Text(
                        movies[index].originalTitle!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
