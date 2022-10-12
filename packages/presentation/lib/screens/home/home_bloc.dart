import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/event_entity.dart';
import 'package:domain/usecases/get_coming_soon_movies_usecase.dart';
import 'package:domain/usecases/get_image_url_usecase.dart';
import 'package:domain/usecases/get_now_showing_movies_usecase.dart';
import 'package:domain/usecases/log_analytics_event_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/screens/home/data/home_data.dart';
import 'package:presentation/screens/movie_details/movie_details_screen.dart';

abstract class HomeBloc implements Bloc<BaseArguments, HomeData> {
  factory HomeBloc(
    GetNowShowingMoviesUseCase getNowShowingMoviesUseCase,
    GetComingSoonMoviesUseCase getComingSoonMoviesUseCase,
    GetImageUrlUseCase getImageUrlUseCase,
    LogAnalyticsEventUseCase logAnalyticsEventUseCase,
  ) =>
      _HomeBloc(
        getNowShowingMoviesUseCase,
        getComingSoonMoviesUseCase,
        getImageUrlUseCase,
        logAnalyticsEventUseCase,
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
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  _HomeBloc(
    this._getNowShowingMoviesUseCase,
    this._getComingSoonMoviesUseCase,
    this._getImageUrlUseCase,
    this._logAnalyticsEventUseCase,
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
    final event = EventEntity('btn_now_showing_movies_click');

    _logAnalyticsEventUseCase(event);

    add(state.copyWith(
      isLoading: true,
    ));

    final movies = await _getNowShowingMoviesUseCase();

    _updateHomeDataWithMovies(movies);
  }

  @override
  Future<void> showComingSoonMovies() async {
    final event = EventEntity('btn_coming_soon_movies_click');

    _logAnalyticsEventUseCase(event);

    add(state.copyWith(
      isLoading: true,
    ));
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
    final event = EventEntity('btn_movie_poster_click');

    _logAnalyticsEventUseCase(event);

    final movieDetailsScreenArguments =
        MovieDetailsScreenArguments(movieDetails: movieDetails);

    appNavigator.push(MovieDetailsScreen.page(movieDetailsScreenArguments));
  }
}
