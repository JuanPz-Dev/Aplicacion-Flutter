import 'package:flutter/material.dart';

import '../../data/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: movie.posterUrl.isEmpty
            ? Container(
                color: const Color(0xFF1A1B1E),
                child: const Center(child: Icon(Icons.movie, size: 36)),
              )
            : Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF1A1B1E),
                  child: const Center(child: Icon(Icons.broken_image)),
                ),
              ),
      ),
    );
  }
}