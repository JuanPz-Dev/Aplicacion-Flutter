import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../movie_detail/presentation/screens/movie_detail_screen.dart';
import '../movies_controller.dart';
import '../widgets/movie_card.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MoviesController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Text(
                'Descubre',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 2, 20, 12),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: TextField(
                onChanged: controller.onQueryChanged,
                textInputAction: TextInputAction.search,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Buscar película',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppTheme.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: switch (controller.status) {
                MoviesStatus.loading =>
                  const Center(child: CircularProgressIndicator()),
                MoviesStatus.error => ErrorView(
                    message: controller.errorMessage,
                    onRetry: controller.loadMovies,
                  ),
                MoviesStatus.success => controller.movies.isEmpty
                    ? const Center(
                        child: Text(
                          'No se encontraron películas',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.67,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: controller.movies.length,
                        itemBuilder: (context, i) {
                          final movie = controller.movies[i];
                          return MovieCard(
                            movie: movie,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MovieDetailScreen(movieId: movie.id),
                              ),
                            ),
                          );
                        },
                      ),
              },
            ),
          ],
        ),
      ),
    );
  }
}