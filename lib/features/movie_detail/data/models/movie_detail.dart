class MovieDetail{
  final int id;
  final String title;
  final String tagline;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final String releaseDate;
  final int? runtime;
  final List<String> genres;

  MovieDetail({
    required this.id,
    required this.title,
    required this.tagline,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    this.runtime,
    required this.genres,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Sin título',
      tagline: json['tagline'] as String? ?? '',
      overview: json['overview'] as String? ?? 'Sin sinopsis disponible.',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] as String? ?? '',
      runtime: json['runtime'] as int?,
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((g) => (g as Map<String, dynamic>)['name'] as String)
          .toList(),
    );
  }

  String get imageUrl {
    final path = backdropPath ?? posterPath;
    return path != null ? 'https://image.tmdb.org/t/p/w780$path' : '';
  }

  String get year =>
      releaseDate.length >= 4 ? releaseDate.substring(0, 4) : '';

  String get runtimeText {
    if (runtime == null || runtime == 0) return '';
    return '${runtime! ~/ 60}h ${runtime! % 60}min';
  }
}