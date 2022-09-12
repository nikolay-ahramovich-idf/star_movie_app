import 'package:flutter/material.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/const.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/home/home_bloc.dart';
import 'package:presentation/screens/home/widgets/movie_card.dart';
import 'package:presentation/screens/home/widgets/shimmer_loader.dart';

enum SelectedMoviesType {
  nowShowing,
  comingSoon,
}

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
  late SelectedMoviesType selectedType;

  void changeMoviesType(SelectedMoviesType newType) {
    setState(
      () => selectedType = newType,
    );
  }

  @override
  void initState() {
    selectedType = SelectedMoviesType.nowShowing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeScreenColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HomeScreenColors.primaryColor,
        centerTitle: false,
        title: const Text(
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
          horizontal: HomeScreenSizes.horizontalPaddingSize,
        ),
        child: Column(
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
                            if (selectedType != SelectedMoviesType.nowShowing) {
                              changeMoviesType(SelectedMoviesType.nowShowing);
                              bloc.showNowShowingMovies();
                            }
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: AppSizes.size18,
                              ),
                              if (selectedType == SelectedMoviesType.nowShowing)
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
                          color: selectedType == SelectedMoviesType.comingSoon
                              ? HomeScreenColors.selectionActiveColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            HomeScreenSizes.selectionBorderRadiusSize,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (selectedType != SelectedMoviesType.comingSoon) {
                              changeMoviesType(SelectedMoviesType.comingSoon);
                              bloc.showComingSoonMovies();
                            }
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: AppSizes.size18,
                              ),
                              if (selectedType == SelectedMoviesType.comingSoon)
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
            StreamBuilder(
              stream: bloc.stream,
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data != null) {
                  return Expanded(
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
                            child: MovieCard(
                              movie.title,
                              rating: movie.rating,
                              genres: movie.genres,
                              runtime: bloc.convertApiRuntime(movie.runtime),
                              certification: movie.certification,
                              imageUrl: bloc.getImageUrlById(movie.imdbId),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const ShimmerLoader();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 15),
        decoration: const BoxDecoration(
          color: HomeScreenColors.primaryColor,
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: HomeScreenColors.primaryColor,
          unselectedItemColor: HomeScreenColors.bottomNavBarIconColorInactive,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.support,
                size: HomeScreenSizes.bottomNavBarIconSize,
              ),
              label: 'Movie Reel',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.airplane_ticket_rounded,
                size: HomeScreenSizes.bottomNavBarIconSize,
              ),
              label: 'Event Ticket',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: HomeScreenSizes.bottomNavBarIconSize,
              ),
              label: 'Alarm',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: HomeScreenSizes.bottomNavBarIconSize,
              ),
              label: 'Single',
            ),
          ],
          onTap: null,
        ),
      ),
    );
  }
}
