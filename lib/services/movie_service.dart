import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
import '../utils/constants.dart';

class MovieService {
  Future<List<Movie>> fetchMovies(String query) async {
    final url = Uri.parse('$baseUrl?s=$query&apikey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        final List results = data['Search'];
        return results.map((movie) {
          return Movie(
            title: movie['Title'],
            year: movie['Year'],
            imdbID: movie['imdbID'],
            type: movie['Type'],
            poster: movie['Poster'],
          );
        }).toList();
      }
    }

    return [];
  }
}
