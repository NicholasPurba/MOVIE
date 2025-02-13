import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onAdd;

  const MovieCard({super.key, required this.movie, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          movie.poster != "N/A"
              ? movie.poster
              : "https://via.placeholder.com/150",
          width: 50,
          fit: BoxFit.cover,
        ),
        title: Text(movie.title),
        subtitle: Text(movie.year),
        trailing:
            onAdd != null
                ? IconButton(
                  icon: Icon(Icons.add, color: Colors.green),
                  onPressed: onAdd,
                )
                : null,
      ),
    );
  }
}
