import 'package:domain/entities/base_movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:presentation/const.dart';
import 'package:presentation/screens/home/widgets/rating.dart';

class MovieCard extends StatelessWidget {
  // final BaseMovieEntity movieEntity;

  // const MovieCard({super.key, required this.movieEntity});

  const MovieCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(
              width: double.infinity,
              child: Image.network(
                'https://image.tmdb.org/t/p/w200/AcKVlWaNVVVFQwro3nLXqPljcYA.jpg',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Rating(
            6.8,
            minCurrentRating: RatingWidgetConfig.minCurrentRating,
            maxCurrentRating: RatingWidgetConfig.maxCurrentRating,
            starColor: RatingWidgetConfig.starColor,
            starSize: RatingWidgetConfig.starSize,
            mode: Mode.base,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'John Week 3 Welcome to Hell',
            style: MovieCardWidget.movieNameTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              Text(
                'Crime',
                style: MovieCardWidget.movieAdditionalInfoTextStyle,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                '\u00b7',
                style: MovieCardWidget.movieAdditionalInfoTextStyle,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                '2hr 10m | R',
                style: MovieCardWidget.movieAdditionalInfoTextStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Container(
//     decoration: BoxDecoration(border: Border.all(width: 2)),
//     child: Column(
//       children: [
//         Image.network(
//           'https://image.tmdb.org/t/p/w300/AcKVlWaNVVVFQwro3nLXqPljcYA.jpg',
//         ),
//         Rating(
//           6.8,
//           minCurrentRating: RatingWidgetConfig.minCurrentRating,
//           maxCurrentRating: RatingWidgetConfig.maxCurrentRating,
//           starColor: RatingWidgetConfig.starColor,
//           mode: Mode.base,
//         ),
//       ],
//     ),
//   );
// }
