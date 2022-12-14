import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/services/app_interaction_service.dart';
import 'package:domain/usecases/get_coming_soon_movies_usecase.dart';
import 'package:domain/usecases/get_image_url_usecase.dart';
import 'package:domain/usecases/get_now_showing_movies_usecase.dart';
import 'package:domain/usecases/set_last_app_interaction_time_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/const.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/screens/home/data/home_data.dart';
import 'package:presentation/screens/movie_details/movie_details_screen.dart';

abstract class HomeBloc implements Bloc<BaseArguments, HomeData> {
  factory HomeBloc(
    GetNowShowingMoviesUseCase getNowShowingMoviesUseCase,
    GetComingSoonMoviesUseCase getComingSoonMoviesUseCase,
    GetImageUrlUseCase getImageUrlUseCase,
    SetLastAppInteractionTimeUseCase setLastAppInteractionTimeUseCase,
  ) =>
      _HomeBloc(
        getNowShowingMoviesUseCase,
        getComingSoonMoviesUseCase,
        getImageUrlUseCase,
        setLastAppInteractionTimeUseCase,
      );

  void changeMoviesType(SelectedMoviesType newType);

  Future<void> showNowShowingMovies();

  Future<void> showComingSoonMovies();

  String? getImageUrlById(String? id);

  String? formatApiRuntime(int? runtime);

  void goToMovieDetailsPage(BaseMovieEntity movieDetails);
}

class _HomeBloc extends BlocImpl<BaseArguments, HomeData> implements HomeBloc {
  final GetNowShowingMoviesUseCase _getNowShowingMoviesUseCase;
  final GetComingSoonMoviesUseCase _getComingSoonMoviesUseCase;
  final GetImageUrlUseCase _getImageUrlUseCase;
  final SetLastAppInteractionTimeUseCase _setLastAppInteractionTimeUseCase;

  _HomeBloc(
    this._getNowShowingMoviesUseCase,
    this._getComingSoonMoviesUseCase,
    this._getImageUrlUseCase,
    this._setLastAppInteractionTimeUseCase,
  ) : super(initState: const HomeData.init());

  @override
  void initState() {
    showNowShowingMovies();
  }

  @override
  void changeMoviesType(SelectedMoviesType newType) {
    final newState = HomeData(
      state.movies,
      newType,
      false,
    );
    add(newState);
  }

  @override
  Future<void> showNowShowingMovies() async {
    logAnalyticsEventUseCase(
      AnalyticsEvents.homeScreenEvents.buttonNowShowingMoviesClick,
    );

    await _setLastAppInteractionTimeUseCase(
      AppInteractionType.nowShowingMovies,
    );

    add(state.copyWith(isLoading: true));

    final movies = await _getNowShowingMoviesUseCase();

    _updateHomeDataWithMovies(movies);
  }

  @override
  Future<void> showComingSoonMovies() async {
    logAnalyticsEventUseCase(
      AnalyticsEvents.homeScreenEvents.buttonComingSoonMoviesClick,
    );

    await _setLastAppInteractionTimeUseCase(
      AppInteractionType.comingSoonMovies,
    );

    add(state.copyWith(isLoading: true));

    final movies = await _getComingSoonMoviesUseCase();
    _updateHomeDataWithMovies(movies);
  }

  void _updateHomeDataWithMovies(List<BaseMovieEntity> movies) {
    final newState = HomeData(
      movies,
      state.selectedMovieType,
      false,
    );
    add(newState);
  }

  @override
  String? getImageUrlById(String? id) {
    return id != null ? _getImageUrlUseCase(id) : id;
  }

  @override
  String? formatApiRuntime(int? runtime) {
    if (runtime == null) return null;
    const minutesInHour = 60;
    final minutes = runtime % minutesInHour;
    final hours = (runtime - minutes) ~/ minutesInHour;
    return '${hours}hr ${minutes}m';
  }

  @override
  void goToMovieDetailsPage(BaseMovieEntity movieDetails) {
    logAnalyticsEventUseCase(
      AnalyticsEvents.homeScreenEvents.buttonMoviePosterClick,
    );

    final movieDetailsScreenArguments =
        MovieDetailsScreenArguments(movieDetails: movieDetails);

    appNavigator.push(MovieDetailsScreen.page(movieDetailsScreenArguments));
  }
}
