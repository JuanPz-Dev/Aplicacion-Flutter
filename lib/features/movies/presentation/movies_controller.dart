import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/network/api_exception.dart';
import '../data/models/movie_model.dart';
import '../data/movies_repository.dart';

enum MoviesStatus { loading, success, error }

class MoviesController extends ChangeNotifier {
  final MoviesRepository _repository;

  MoviesController({MoviesRepository? repository})
      : _repository = repository ?? MoviesRepository();

  MoviesStatus status = MoviesStatus.loading;
  List<Movie> movies = [];
  String errorMessage = '';
  String query = '';

  Timer? _debounce;
  int _requestId = 0;

  void onQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      query = value.trim();
      loadMovies();
    });
  }
  Future<void> loadMovies() async {
    final requestId = ++_requestId;
    status = MoviesStatus.loading;
    notifyListeners();
    try {
      final result = query.isEmpty
          ? await _repository.getPopularMovies()
          : await _repository.searchMovies(query);
      if (requestId != _requestId) return; // llegó una respuesta vieja
      movies = result;
      status = MoviesStatus.success;
    } on ApiException catch (e) {
      if (requestId != _requestId) return;
      errorMessage = e.message;
      status = MoviesStatus.error;
    } catch (_) {
      if (requestId != _requestId) return;
      errorMessage = 'Ocurrió un error inesperado';
      status = MoviesStatus.error;
    }
    notifyListeners();
  }
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}