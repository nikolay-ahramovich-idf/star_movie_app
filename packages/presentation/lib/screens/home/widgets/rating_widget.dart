import 'package:flutter/material.dart';

enum Mode { base, full }

class RatingWidget extends StatelessWidget {
  static const minNewRating = 0;
  static const maxNewRating = 5;

  final double rating;
  final double minCurrentRating;
  final double maxCurrentRating;
  final Color starColor;
  final double starSize;
  final Mode mode;

  const RatingWidget(
    this.rating, {
    required this.minCurrentRating,
    required this.maxCurrentRating,
    required this.starColor,
    required this.starSize,
    required this.mode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedRating = _normalizeRating(
      rating,
      minCurrentRating: minCurrentRating,
      maxCurrentRating: maxCurrentRating,
    );

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
