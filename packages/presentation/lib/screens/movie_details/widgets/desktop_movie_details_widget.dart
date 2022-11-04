import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/const.dart';
import 'package:presentation/extensions/string.dart';
import 'package:presentation/screens/movie_details/data/movie_details_data.dart';
import 'package:presentation/screens/movie_details/movie_details_bloc.dart';
import 'package:presentation/screens/movie_details/widgets/cast_widget.dart';
import 'package:presentation/screens/movie_details/widgets/details_selection_widget.dart';
import 'package:presentation/screens/movie_details/widgets/shimmer_loader_widget.dart';
import 'package:presentation/screens/movie_details/widgets/synopsis_widget.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/styles.dart';
import 'package:presentation/widgets/image_widget.dart';
import 'package:presentation/widgets/rating_widget.dart';

class DesktopMovieDetailsWidget extends StatelessWidget {
  final MovieDetailsBloc bloc;

  const DesktopMovieDetailsWidget(this.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: StreamBuilder<MovieDetailsData?>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final movieDetails = snapshot.data?.movieDetails;
          final runtime = snapshot.data?.formattedRuntime;
          final cast = snapshot.data?.cast;

          if (movieDetails != null) {
            final moviePosterImageUrl =
                bloc.getImageUrlById(movieDetails.imdbId);

            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: AppSizes.size0,
                  right: AppSizes.size0,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: ImageWidget(moviePosterImageUrl),
                  ),
                ),
                Positioned(
                  top: AppSizes.size0,
                  left: AppSizes.size0,
                  right: AppSizes.size0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.screensHorizontalPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: bloc.handleBackPressed,
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                              size: MovieDetailsScreenSizes.navigationIconSize,
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.green,
                            child: Image.asset(
                              AssetsImagesPaths.respondArrow,
                              height:
                                  MovieDetailsScreenSizes.navigationIconSize,
                            ),
                            onTap: () => bloc.shareMovie(
                              appLocalizations.shareMovieMessage,
                              appLocalizations.localeName,
                              movieDetails.tmdbId ?? 0,
                              appLocalizations.intentTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: currentHeight - AppSizes.size282,
                  left: AppSizes.size0,
                  right: AppSizes.size0,
                  bottom: AppSizes.size0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Positioned(
                  top: AppSizes.size10,
                  left: AppSizes.screensHorizontalPadding,
                  right: AppSizes.screensHorizontalPadding,
                  bottom: AppSizes.size0,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: AppSizes.size57,
                            height: AppSizes.size57,
                            decoration: const BoxDecoration(
                              color: AppColors.transparentWhite50,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              AssetsImagesPaths.playButtonPath,
                            ),
                          ),
                          const SizedBox(height: AppSizes.size16),
                          ImageWidget(moviePosterImageUrl),
                          const SizedBox(height: AppSizes.size32),
                          Text(
                            movieDetails.title ?? '',
                            style: MovieDetailsScreenStyles.movieNameStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSizes.size14),
                          Text(
                            '$runtime | ${movieDetails.certification}',
                            style: MovieDetailsScreenStyles
                                .movieAdditionalDataStyle,
                          ),
                          const SizedBox(height: AppSizes.size9),
                          Text(
                            getGenresPresentation(movieDetails.genres ?? []),
                            style: MovieDetailsScreenStyles
                                .movieAdditionalDataStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSizes.size20),
                          RatingWidget(
                            movieDetails.rating ?? 0,
                            minCurrentRating:
                                RatingWidgetConfig.minCurrentRating,
                            maxCurrentRating:
                                RatingWidgetConfig.maxCurrentRating,
                            starColor: AppColors.gold,
                            starSize: MovieDetailsScreenSizes.ratingStarSize,
                            mode: Mode.full,
                          ),
                          const SizedBox(height: AppSizes.size20),
                          const DetailsSelectionWidget(),
                          const SizedBox(height: AppSizes.size32),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SynopsisWidget(
                                  movieDetails.overview,
                                  handleShowMoreLessPressed:
                                      bloc.handleShowMoreLessPressed,
                                ),
                              ),
                              const SizedBox(height: AppSizes.size32),
                              Expanded(child: CastWidget(cast)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const ShimmerLoaderWidget();
          }
        },
      ),
    );
  }

  String getGenresPresentation(Iterable<String> genres) {
    return genres.map((genre) => genre.capitalize()).join(', ');
  }
}
