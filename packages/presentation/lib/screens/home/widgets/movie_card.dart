import 'package:flutter/material.dart';
import 'package:presentation/const.dart';
import 'package:presentation/extensions/string.dart';
import 'package:presentation/screens/home/widgets/rating.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final double rating;
  final List<String> genres;
  final String runtime;
  final String certification;
  final String? imageUrl;

  const MovieCard(
    this.title, {
    required this.rating,
    required this.genres,
    required this.runtime,
    required this.certification,
    this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 2 / 3,
          child: SizedBox(
            width: double.infinity,
            child: imageUrl == null
                ? const ImageNotExist()
                : Image.network(
                    imageUrl as String,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: ImageNotExist(),
                    ),
                    fit: BoxFit.contain,
                  ),
          ),
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Rating(
          rating,
          minCurrentRating: RatingWidgetConfig.minCurrentRating,
          maxCurrentRating: RatingWidgetConfig.maxCurrentRating,
          starColor: RatingWidgetConfig.starColor,
          starSize: RatingWidgetConfig.starSize,
          mode: Mode.base,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Text(
          title,
          style: MovieCardWidgetStyles.movieNameTextStyle,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Wrap(
          children: [
            Text(
              genres.first.capitalize(),
              style: MovieCardWidgetStyles.movieAdditionalInfoTextStyle,
            ),
            const SizedBox(
              width: AppSizes.size3,
            ),
            const Text(
              '\u00b7',
              style: MovieCardWidgetStyles.movieAdditionalInfoTextStyle,
            ),
            const SizedBox(
              width: AppSizes.size3,
            ),
            Text(
              runtime,
              style: MovieCardWidgetStyles.movieAdditionalInfoTextStyle,
            ),
            const SizedBox(
              width: AppSizes.size2,
            ),
            const Text(
              '|',
              style: MovieCardWidgetStyles.movieAdditionalInfoTextStyle,
            ),
            const SizedBox(
              width: AppSizes.size2,
            ),
            Text(
              certification,
              style: MovieCardWidgetStyles.movieAdditionalInfoTextStyle,
            ),
          ],
        )
      ],
    );
  }
}

class ImageNotExist extends StatelessWidget {
  const ImageNotExist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Image Not Exist Yet',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
