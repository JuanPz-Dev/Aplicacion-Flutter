import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../movie_detail_controller.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailController(movieId)..load(),
      child: const _DetailView(),
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MovieDetailController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: switch (controller.status) {
        DetailStatus.loading =>
          const Center(child: CircularProgressIndicator()),
        DetailStatus.error => ErrorView(
            message: controller.errorMessage,
            onRetry: controller.load,
          ),
        DetailStatus.success => _Content(controller: controller),
      },
    );
  }
}

class _Content extends StatelessWidget {
  final MovieDetailController controller;

  const _Content({required this.controller});

  @override
  Widget build(BuildContext context) {
    final movie = controller.movie!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 380,
            width: double.infinity,
            child: movie.imageUrl.isEmpty
                ? Container(color: AppTheme.surface)
                : Image.network(movie.imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (movie.tagline.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    movie.tagline,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(movie.voteAverage.toStringAsFixed(1)),
                    const SizedBox(width: 16),
                    Text(
                      [movie.year, movie.runtimeText]
                          .whereType<String>()
                          .where((t) => t.isNotEmpty)
                          .join('  •  '),
                      style: const TextStyle(color: AppTheme.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: movie.genres
                      .map((g) => Chip(
                            label: Text(g),
                            backgroundColor: AppTheme.surface,
                            side: BorderSide.none,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sinopsis',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview,
                  style: const TextStyle(height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}