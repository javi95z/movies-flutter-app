import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_app/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = 'fd94b9a423e09c3717c36d73af49f46b';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    final response = await http.get(url);
    final decoded = json.decode(response.body);
    final movies = new Movies.fromJson(decoded['results']);
    return movies.items;
  }
}
