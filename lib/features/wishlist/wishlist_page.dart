import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/app/router.dart';
import 'package:imdb_app/data/model/user/user_model.dart';
import 'package:imdb_app/data/services/constant/api_constants.dart';
import 'package:imdb_app/data/services/user_service.dart';
import 'package:imdb_app/features/home/utils/image_utils.dart';
import 'package:imdb_app/data/model/movie/movie_model.dart';
import 'package:imdb_app/features/profile/utils/auth_provider.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  UserService userService = UserService();
  UserModel? currentUser;
  List<MovieModel> wishlistItems = [];
  AuthProvider authProvider = AuthProvider();
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    currentUser = authProvider.user;
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    final response = await userService.getWishlist(currentUser!.id!);
    if (response != null) {
      setState(() {
        wishlistItems = (response.data ?? [])
            .map<MovieModel>((item) => MovieModel.fromJson(item))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.home),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  Text(
                    "Wishlist",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 32),
                ],
              ),
            ),

            wishlistItems.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      padding: EdgeInsets.all(18),
                      itemCount: wishlistItems.length,
                      itemBuilder: (context, index) {
                        final movie = wishlistItems[index];
                        return wishlistCard(context, movie);
                      },
                    ),
                  )
                : noMovieContainer(),
          ],
        ),
      ),
    );
  }

  Expanded noMovieContainer() {
    return Expanded(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 230),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/img/magic-box.png", width: 76, height: 76),
              SizedBox(height: 16),
              Text(
                "There is no movie yet!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Find your movie by Type title, categories, years, etc.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container wishlistCard(BuildContext context, MovieModel movie) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary.withAlpha(32),
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: () => context.push("/movie/${movie.id}"),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: 16,
            children: [
              Container(
                width: 120,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ImageHelper.getImage(
                      movie.posterPath,
                      ApiConstants.posterSize.m,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.genres![0].name,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleSmall!.color,
                      ),
                    ),
                    Text(
                      movie.title ?? "Title",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Movie",
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.titleSmall!.color,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.star_rounded,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          (movie.voteAverage! / 2).toStringAsFixed(1),
                          style: TextStyle(color: Colors.yellow),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(Icons.bookmark, color: Colors.red, size: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
