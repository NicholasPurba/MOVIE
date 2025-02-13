import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../widgets/movie_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Movie> favoriteMovies;

  const FavoritesScreen(this.favoriteMovies, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body:
          favoriteMovies.isEmpty
              ? Center(child: Text("No favorites yet"))
              : ListView.builder(
                itemCount: favoriteMovies.length,
                itemBuilder: (context, index) {
                  final movie = favoriteMovies[index];
                  return MovieCard(movie: movie);
                },
              ),
    );
  }
}
