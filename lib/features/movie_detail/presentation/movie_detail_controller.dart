import 'package:flutter/foundation.dart';

import '../../../core/network/api_exception.dart';
import '../data/models/movie_detail.dart';
import '../data/movie_detail_repository.dart';

enum DetailStatus { loading, success, error }

class MovieDetailController extends ChangeNotifier {
  final int movieId;
  final MovieDetailRepository _repository;

  MovieDetailController(this.movieId, {MovieDetailRepository? repository})
      : _repository = repository ?? MovieDetailRepository();

  DetailStatus status = DetailStatus.loading;
  MovieDetail? movie;
  String errorMessage = '';

  Future<void> load() async {
    status = DetailStatus.loading;
    notifyListeners();

    try {
      movie = await _repository.getMovieDetail(movieId);
      status = DetailStatus.success;
    } on ApiException catch (e) {
      errorMessage = e.message;
      status = DetailStatus.error;
    } catch (_) {
      errorMessage = 'Ocurrió un error inesperado';
      status = DetailStatus.error;
    }

    notifyListeners();
  }
}