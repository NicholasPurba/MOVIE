import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../widgets/movie_card.dart';
import 'favorites_screen.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Movie> movies = [];
  List<Movie> favoriteMovies = [];
  bool isLoading = false;

  Future<void> fetchMovies(String query) async {
    setState(() {
      isLoading = true;
    });

    final movieService = MovieService();
    final fetchedMovies = await movieService.fetchMovies(query);

    setState(() {
      movies = fetchedMovies;
      isLoading = false;
    });
  }

  void addToFavorites(Movie movie) {
    if (!favoriteMovies.any((fav) => fav.imdbID == movie.imdbID)) {
      setState(() {
        favoriteMovies.add(movie);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${movie.title} added to favorites!")),
      );
    }
  }

  void onSearch(String query) {
    if (query.isNotEmpty) {
      fetchMovies(query);
    } else {
      setState(() {
        movies = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OMDb Movies"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: "Search movies...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : movies.isEmpty
              ? Center(child: Text("No movies found"))
              : ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(
                    movie: movie,
                    onAdd: () => addToFavorites(movie),
                  );
                },
              ),
      floatingActionButton:
          favoriteMovies.isNotEmpty
              ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesScreen(favoriteMovies),
                    ),
                  );
                },
                child: Icon(Icons.favorite),
              )
              : null,
    );
  }
}
