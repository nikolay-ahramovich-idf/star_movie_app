import 'dart:ui';

import 'package:domain/entities/base_movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/const.dart';
import 'package:presentation/extensions/string.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/movie_details/data/movie_details_data.dart';
import 'package:presentation/screens/movie_details/movie_details_bloc.dart';
import 'package:presentation/screens/movie_details/widgets/shimmer_loader_widget.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/styles.dart';
import 'package:presentation/widgets/image_widget.dart';
import 'package:presentation/widgets/rating_widget.dart';
import 'package:readmore/readmore.dart';

class MovieDetailsScreenArguments extends BaseArguments {
  final BaseMovieEntity movieDetails;

  MovieDetailsScreenArguments({
    required this.movieDetails,
    Function(dynamic value)? result,
  }) : super(result: result);
}

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  static const _routeName = '/MovieDetailsScreen';

  static BasePage page(MovieDetailsScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const MovieDetailsScreen(),
        arguments: arguments,
      );

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState
    extends BlocScreenState<MovieDetailsScreen, MovieDetailsBloc> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

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
                    child: ImageWidget(
                      moviePosterImageUrl,
                    ),
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
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: null,
                            icon: Image.asset(
                              AssetsImagesPaths.respondArrow,
                              height:
                                  MovieDetailsScreenSizes.navigationIconSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: AppSizes.size282,
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
                          const SizedBox(
                            height: AppSizes.size16,
                          ),
                          ImageWidget(
                            moviePosterImageUrl,
                          ),
                          const SizedBox(
                            height: AppSizes.size32,
                          ),
                          Text(
                            movieDetails.title ?? '',
                            style: MovieDetailsScreenStyles.movieNameStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: AppSizes.size14,
                          ),
                          Text(
                            '$runtime | ${movieDetails.certification}',
                            style: MovieDetailsScreenStyles
                                .movieAdditionalDataStyle,
                          ),
                          const SizedBox(
                            height: AppSizes.size9,
                          ),
                          Text(
                            getGenresPresentation(movieDetails.genres ?? []),
                            style: MovieDetailsScreenStyles
                                .movieAdditionalDataStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: AppSizes.size20,
                          ),
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
                          const SizedBox(
                            height: AppSizes.size20,
                          ),
                          Container(
                            width: double.infinity,
                            height: AppSizes.size45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                HomeScreenSizes.selectionBorderRadiusSize,
                              ),
                              border: Border.all(
                                width: HomeScreenSizes.selectionBorderWidth,
                                color: HomeScreenColors.selectionBorderColor,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      AppSizes.size4,
                                      AppSizes.size4,
                                      AppSizes.size0,
                                      AppSizes.size4,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: HomeScreenColors
                                            .selectionActiveColor,
                                        borderRadius: BorderRadius.circular(
                                          HomeScreenSizes
                                              .selectionBorderRadiusSize,
                                        ),
                                      ),
                                      child: Text(
                                        appLocalizations.detailCategoryLabel,
                                        style: SelectionButtonStyles
                                            .activeButtonTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      AppSizes.size4,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          HomeScreenSizes
                                              .selectionBorderRadiusSize,
                                        ),
                                      ),
                                      child: Text(
                                        appLocalizations.reviewsCategoryLabel,
                                        style: SelectionButtonStyles
                                            .inactiveButtonTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      AppSizes.size4,
                                      AppSizes.size4,
                                      AppSizes.size4,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(
                                          HomeScreenSizes
                                              .selectionBorderRadiusSize,
                                        ),
                                      ),
                                      child: Text(
                                        appLocalizations.showtimeCategoryLabel,
                                        style: SelectionButtonStyles
                                            .inactiveButtonTextStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppSizes.size32,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalizations.synopsisHeaderLabel,
                                style: MovieDetailsScreenStyles
                                    .movieDescriptionHeaderStyle,
                              ),
                              const SizedBox(
                                height: AppSizes.size14,
                              ),
                              ReadMoreText(
                                movieDetails.overview ?? '',
                                style: MovieDetailsScreenStyles
                                    .movieDescriptionBodyStyle,
                                trimLines: 4,
                                trimMode: TrimMode.Line,
                                trimCollapsedText:
                                    appLocalizations.showMoreButtonLabel,
                                trimExpandedText:
                                    ' ${appLocalizations.showLessButtonLabel}',
                                moreStyle:
                                    MovieDetailsScreenStyles.showMoreStyle,
                                lessStyle:
                                    MovieDetailsScreenStyles.showMoreStyle,
                              ),
                              const SizedBox(
                                height: AppSizes.size32,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    appLocalizations.castAndCrewHeaderLabel,
                                    style: MovieDetailsScreenStyles
                                        .movieDescriptionHeaderStyle,
                                  ),
                                  Text(
                                    appLocalizations.viewAllButtonLabel,
                                    style:
                                        MovieDetailsScreenStyles.showMoreStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: AppSizes.size24,
                              ),
                              Table(
                                // defaultColumnWidth: const IntrinsicColumnWidth(),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: const {
                                  0: FixedColumnWidth(
                                    AppSizes.size49,
                                  ),
                                  1: FixedColumnWidth(
                                    AppSizes.size12,
                                  ),
                                  2: FlexColumnWidth(),
                                  3: FixedColumnWidth(
                                    AppSizes.size20,
                                  ),
                                  4: FixedColumnWidth(
                                    AppSizes.size24,
                                  )
                                },
                                children: [
                                  if (cast != null)
                                    for (final castItem in cast)
                                      TableRow(
                                        children: [
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    castItem.posterPath != null
                                                        ? NetworkImage(
                                                            castItem
                                                                .posterPath!,
                                                          )
                                                        : null,
                                                radius: AppSizes.size49 / 2,
                                              ),
                                              const SizedBox(
                                                height: AppSizes.size18,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: AppSizes.size12,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                castItem.actorName,
                                                style: MovieDetailsScreenStyles
                                                    .movieDescriptionCastNameStyle,
                                              ),
                                              const SizedBox(
                                                height: AppSizes.size18,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              _getThreeDotsWidget(),
                                              const SizedBox(
                                                height: AppSizes.size18,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: AppSizes.size24,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                castItem.characterName
                                                    .toUpperCase(),
                                                style: MovieDetailsScreenStyles
                                                    .movieDescriptionRoleNameStyle,
                                              ),
                                              const SizedBox(
                                                height: AppSizes.size18,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                ],
                              )
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

  Widget _getThreeDotsWidget() {
    const dotsNumber = 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int j = 0; j < dotsNumber; j++)
          Padding(
            padding: const EdgeInsets.only(
              right: AppSizes.size2,
            ),
            child: Container(
              width: AppSizes.size4,
              height: AppSizes.size4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.transparentWhite50,
              ),
            ),
          )
      ],
    );
  }
}

String getGenresPresentation(Iterable<String> genres) {
  return genres.map((genre) => genre.capitalize()).join(', ');
}