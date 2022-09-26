import 'package:flutter/material.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/const.dart';
import 'package:presentation/extensions/bloc.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/home/data/home_data.dart';
import 'package:presentation/screens/home/home_bloc.dart';
import 'package:presentation/screens/home/widgets/movie_card_widget.dart';
import 'package:presentation/screens/home/widgets/shimmer_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const _routeName = '/HomeScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const HomeScreen(),
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BlocScreenState<HomeScreen, HomeBloc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        centerTitle: false,
        title: Text(
          'Star Movie',
          style: HomeScreenStyles.appBarStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: AppSizes.size10,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: HomeScreenSizes.searchIconSize,
              ),
              color: HomeScreenColors.searchIconButtonColor,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.screensHorizontalPadding,
        ),
        child: StreamBuilder<HomeData?>(
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
                                color: selectedType ==
                                        SelectedMoviesType.nowShowing
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
                                  children: [
                                    const SizedBox(
                                      width: AppSizes.size18,
                                    ),
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
                                      'Now Showing',
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
                              0,
                              AppSizes.size4,
                              AppSizes.size4,
                              AppSizes.size4,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedType ==
                                        SelectedMoviesType.comingSoon
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
                                  children: [
                                    const SizedBox(
                                      width: AppSizes.size18,
                                    ),
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
                                      'Coming Soon',
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
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: data.movies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: HomeScreenSizes.gridChildAspecRatio,
                        crossAxisSpacing: AppSizes.size13,
                        mainAxisSpacing:
                            HomeScreenSizes.gridViewMainAxisSpacing,
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
                              certification: movie.certification,
                              imageUrl: bloc.getImageUrlById(
                                movie.imdbId,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const ShimmerLoader();
            }
          },
        ),
      ),
    );
  }
}
