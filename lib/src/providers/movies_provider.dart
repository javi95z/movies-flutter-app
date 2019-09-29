import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_app/src/models/actor_model.dart';
import 'package:movies_flutter_app/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = 'fd94b9a423e09c3717c36d73af49f46b';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _popular = new List();
  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;
  Stream<List<Movie>> get popularStream => _popularStreamController.stream;
  void disposeStreams() {
    _popularStreamController?.close();
  }

  Future<List<Movie>> _proccessResponse(Uri url) async {
    final response = await http.get(url);
    final decoded = json.decode(response.body);
    final movies = new Movies.fromJson(decoded['results']);
    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await _proccessResponse(url);
  }

  Future<List<Movie>> getPopular() async {
    if (_loading) return [];
    _loading = true;
    _popularPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });
    final resp = await _proccessResponse(url);
    _popular.addAll(resp);
    popularSink(_popular);
    _loading = false;
    return resp;
  }

  Future<List<Actor>> getCast(String movieId) async {
    if (_loading) return [];
    _loading = true;
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {'api_key': _apiKey, 'language': _language});
    final resp = await http.get(url);
    final decoded = json.decode(resp.body);
    final cast = new Cast.fromJson(decoded['cast']);
    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    return await _proccessResponse(url);
  }
}
