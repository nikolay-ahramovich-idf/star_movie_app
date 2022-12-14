import 'package:flutter/material.dart';
import 'package:presentation/const.dart';
import 'package:presentation/extensions/string.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/styles.dart';
import 'package:presentation/widgets/image_widget.dart';
import 'package:presentation/widgets/rating_widget.dart';

class MovieCardWidget extends StatelessWidget {
  final String? title;
  final double? rating;
  final List<String>? genres;
  final String? runtime;
  final String certification;
  final String? imageUrl;

  const MovieCardWidget(
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
            child: ImageWidget(imageUrl),
          ),
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        RatingWidget(
          rating ?? 0,
          minCurrentRating: RatingWidgetConfig.minCurrentRating,
          maxCurrentRating: RatingWidgetConfig.maxCurrentRating,
          starColor: AppColors.gold,
          starSize: HomeScreenSizes.ratingStarSize,
          mode: Mode.base,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Text(
          title ?? '',
          style: MovieCardWidgetStyles.movieNameTextStyle,
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Wrap(
          children: [
            Text(
              genres != null && genres!.isNotEmpty
                  ? genres!.first.capitalize()
                  : '',
              style: MovieCardWidgetStyles.movieAdditionalInfoTextStyle,
            ),
            const SizedBox(
              width: AppSizes.size3,
            ),
            Text(
              '\u00b7',
              style: MovieCardWidgetStyles.movieAdditionalInfoTextStyle,
            ),
            const SizedBox(
              width: AppSizes.size3,
            ),
            Text(
              runtime ?? '',
              style: MovieCardWidgetStyles.movieAdditionalInfoTextStyle,
            ),
            const SizedBox(
              width: AppSizes.size2,
            ),
            Text(
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
