import 'package:flutter/material.dart';
import 'package:imdb_app/data/model/movie_model.dart';

class MovieCarousel extends StatelessWidget {
  final MovieModel movie;
  final bool isMoviePage;
  const MovieCarousel({
    super.key,
    required this.isMoviePage,
    required this.movie,
  });

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
                child: Image.network(movie.primaryImage!, fit: BoxFit.cover),
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
                        movie.primaryTitle,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      ?isMoviePage
                          ? Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  "${movie.runtimeMinutes} minutes",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: 40),
                                Icon(
                                  Icons.star,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  "${movie.averageRating} (IMDb)",
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            )
                          : null,
                      SizedBox(height: 8),
                      Text(
                        movie.description!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      ?!isMoviePage
                          ? TextButton(
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
                            )
                          : null,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
