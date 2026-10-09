import '../../../core/network/api_client.dart';
import 'models/movie_detail.dart';

class MovieDetailRepository {
  final ApiClient _client;

  MovieDetailRepository({ApiClient? client}) : _client = client ?? ApiClient();

  Future<MovieDetail> getMovieDetail(int id) async {
    final data = await _client.get('/movie/$id');
    return MovieDetail.fromJson(data);
  }
}