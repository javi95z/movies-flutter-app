import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_flutter_app/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = 'fd94b9a423e09c3717c36d73af49f46b';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularPage = 0;
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
    _popularPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });
    final resp = await _proccessResponse(url);
    _popular.addAll(resp);
    popularSink(_popular);
    return resp;
  }
}
