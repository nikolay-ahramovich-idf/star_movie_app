import 'package:flutter/material.dart';

enum Mode { base, full }

class Rating extends StatelessWidget {
  static const minNewRating = 0;
  static const maxNewRating = 5;

  late final double normalizedRating;
  final Color starColor;
  final double starSize;
  final Mode mode;

  Rating(
    double rating, {
    required double minCurrentRating,
    required double maxCurrentRating,
    required this.starColor,
    required this.starSize,
    required this.mode,
  }) {
    normalizedRating = _normalizeRating(
      rating,
      minCurrentRating: minCurrentRating,
      maxCurrentRating: maxCurrentRating,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ratingInStars = normalizedRating.round();

    return Row(
      children: [
        if (mode == Mode.full) Text('$normalizedRating/$maxNewRating'),
        Row(
          children: [
            for (int i = minNewRating + 1; i <= maxNewRating; i++)
              Icon(
                i <= ratingInStars ? Icons.star : Icons.star_border_outlined,
                color: starColor,
                size: starSize,
              )
          ],
        )
      ],
    );
  }

  double _normalizeRating(
    double rating, {
    required double minCurrentRating,
    required double maxCurrentRating,
  }) {
    return ((maxNewRating - minNewRating) *
            (rating - minCurrentRating) /
            (maxCurrentRating - minCurrentRating)) +
        minNewRating;
  }
}
