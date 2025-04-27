import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  static const routeName = "movie-screen";
  final String movieId;

  MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('movieId: $movieId'),
      ),
    );
  }
}
