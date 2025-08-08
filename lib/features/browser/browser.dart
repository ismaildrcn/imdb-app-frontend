import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/app/utils/debounce.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/data/services/movie_service.dart';
import 'package:imdb_app/data/services/search_service.dart';
import 'package:imdb_app/features/home/home.dart';
import 'package:imdb_app/features/home/widgets/movie_list_page_card.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({super.key});

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  final TextEditingController _searchController = TextEditingController();
  late final MovieService _movieService;
  late final SearchService _searchService;
  List<MovieModel> popuplarMovies = [];
  List<MovieModel> searchMoviesData = [];
  List<MovieModel> searchMovies = [];
  bool isLoading = false;
  final Debouncer _debouncer = Debouncer(delay: Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => _debouncer.run(() => _getMovies()));
    _movieService = MovieService();
    _searchService = SearchService();
    loadData();
  }

  @override
  void dispose() {
    _searchController.removeListener(_getMovies); // Listener'ı temizle
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getMovies() async {
    setState(() {
      isLoading = true;
    });
    if (_searchController.text.isNotEmpty &&
        _searchController.text.length > 2) {
      List<MovieModel> searchMovies = await _searchService.fetchMovies(
        searchText: _searchController.text,
      );
      setState(() {
        searchMoviesData = searchMovies;
        isLoading = false;
      });
    } else {
      setState(() {
        searchMoviesData = [];
        isLoading = false;
      });
    }
  }

  Future<void> loadData() async {
    final popular = await _movieService.fetchMovies(type: MovieTypes.popular);
    setState(() {
      popuplarMovies = popular;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavBar(context, "Browser"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: CustomScrollView(
            slivers: [
              _searchTextField(context),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              isLoading
                  ? SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _searchResultField(),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              _topRatedField(),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _searchTextField(BuildContext context) {
    return SliverToBoxAdapter(
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Icon(Icons.search),
          ),
          fillColor: Theme.of(context).colorScheme.onSurface,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
              width: 2,
            ),
          ),
          hintText: "Type titles",
        ),
      ),
    );
  }

  SliverList _searchResultField() {
    return SliverList.builder(
      itemCount: searchMoviesData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => context.push("/movie/${searchMoviesData[index].id}"),
          child: MovieListPageCard(movie: searchMoviesData[index]),
        );
      },
    );
  }

  SliverToBoxAdapter _topRatedField() {
    return SliverToBoxAdapter(
      child: popuplarMovies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : HorizontalMoviesCardList(
              title: "Top Rated",
              allMovies: popuplarMovies,
              displayMovies: popuplarMovies.sublist(0, 5),
            ),
    );
  }
}
