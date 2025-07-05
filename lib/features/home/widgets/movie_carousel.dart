import 'package:flutter/material.dart';

class MovieCarousel extends StatelessWidget {
  final bool isMoviePage;
  const MovieCarousel({super.key, required this.isMoviePage});

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
                      ?isMoviePage
                          ? Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  "169 minutes",
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
                                  "7.2 (IMDb)",
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
                        "An internal succession war within House Targaryen at the height of its power, 172 years before the birth of Daenerys Targaryen.",
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
