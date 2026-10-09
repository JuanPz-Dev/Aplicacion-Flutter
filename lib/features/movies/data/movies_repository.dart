import '../../../core/network/api_client.dart';
import 'models/movie_model.dart';

class MoviesRepository {
  final ApiClient _client;

  MoviesRepository({ApiClient? client}) : _client = client ?? ApiClient();

  Future<List<Movie>> getPopularMovies() async {
    final data = await _client.get('/movie/popular');
    return _parseMovies(data);
  }

  Future<List<Movie>> searchMovies(String query) async {
    final data = await _client.get('/search/movie', params: {'query': query});
    return _parseMovies(data);
  }

  List<Movie> _parseMovies(Map<String, dynamic> data) {
    final results = data['results'] as List<dynamic>;
    return results
        .map((json) => Movie.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}