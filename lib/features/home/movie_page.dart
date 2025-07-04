import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  final String movieId;
  const MoviePage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(movieId));
  }
}
