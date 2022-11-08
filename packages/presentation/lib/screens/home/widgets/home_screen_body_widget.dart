import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/const.dart';
import 'package:presentation/screens/home/data/home_data.dart';
import 'package:presentation/screens/home/home_bloc.dart';
import 'package:presentation/screens/home/widgets/movie_card_widget.dart';
import 'package:presentation/screens/home/widgets/shimmer_loader.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/utils/responsive.dart';
import 'package:presentation/utils/styles.dart';

class HomeScreenBodyWidget extends StatelessWidget {
  final HomeBloc bloc;
  final bool isDesktop;

  const HomeScreenBodyWidget({
    required this.bloc,
    required this.isDesktop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return StreamBuilder<HomeData?>(
      stream: bloc.stream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data != null && !data.isLoading) {
          final selectedType = data.selectedMovieType;

          return Column(
            children: [
              const SizedBox(
                height: AppSizes.size24,
              ),
              Container(
                width: double.infinity,
                height: AppSizes.size50,
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
                          0,
                          AppSizes.size4,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedType == SelectedMoviesType.nowShowing
                                ? HomeScreenColors.selectionActiveColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              HomeScreenSizes.selectionBorderRadiusSize,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (selectedType !=
                                  SelectedMoviesType.nowShowing) {
                                bloc.changeMoviesType(
                                    SelectedMoviesType.nowShowing);
                                bloc.showNowShowingMovies();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: !isDesktop
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.start,
                              children: [
                                if (selectedType ==
                                    SelectedMoviesType.nowShowing)
                                  const Image(
                                    image: AssetImage(
                                      AssetsImagesPaths.playButtonPath,
                                    ),
                                  ),
                                const SizedBox(
                                  width: AppSizes.size6,
                                ),
                                Text(
                                  appLocalizations.nowShowingCategoryLabel,
                                  style: selectedType ==
                                          SelectedMoviesType.nowShowing
                                      ? SelectionButtonStyles
                                          .activeButtonTextStyle
                                      : SelectionButtonStyles
                                          .inactiveButtonTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSizes.size0,
                          AppSizes.size4,
                          AppSizes.size4,
                          AppSizes.size4,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedType == SelectedMoviesType.comingSoon
                                ? HomeScreenColors.selectionActiveColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              HomeScreenSizes.selectionBorderRadiusSize,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (selectedType !=
                                  SelectedMoviesType.comingSoon) {
                                bloc.changeMoviesType(
                                    SelectedMoviesType.comingSoon);
                                bloc.showComingSoonMovies();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: !isDesktop
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.start,
                              children: [
                                if (selectedType ==
                                    SelectedMoviesType.comingSoon)
                                  const Image(
                                    image: AssetImage(
                                      AssetsImagesPaths.playButtonPath,
                                    ),
                                  ),
                                const SizedBox(
                                  width: AppSizes.size6,
                                ),
                                Text(
                                  appLocalizations.comingSoonCategoryLabel,
                                  style: selectedType ==
                                          SelectedMoviesType.comingSoon
                                      ? SelectionButtonStyles
                                          .activeButtonTextStyle
                                      : SelectionButtonStyles
                                          .inactiveButtonTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.size24,
              ),
              if (data.movies.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: data.movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          Responsive.moviesCountPerScreenSize(context),
                      childAspectRatio: HomeScreenSizes.gridChildAspecRatio,
                      crossAxisSpacing: AppSizes.size13,
                      mainAxisSpacing: HomeScreenSizes.gridViewMainAxisSpacing,
                    ),
                    itemBuilder: (context, index) {
                      final movie = data.movies[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          bloc.goToMovieDetailsPage(movie);
                        },
                        child: SingleChildScrollView(
                          child: MovieCardWidget(
                            movie.title,
                            rating: movie.rating,
                            genres: movie.genres,
                            runtime: bloc.formatApiRuntime(
                              movie.runtime,
                            ),
                            certification: movie.certification ??
                                appLocalizations.notRatedLabel,
                            imageUrl: bloc.getImageUrlById(
                              movie.imdbId,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (data.movies.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      appLocalizations.moviesNotAvailableErrorMessage,
                      style: HomeScreenStyles.white24Style,
                    ),
                  ),
                )
            ],
          );
        } else {
          return const ShimmerLoader();
        }
      },
    );
  }
}
