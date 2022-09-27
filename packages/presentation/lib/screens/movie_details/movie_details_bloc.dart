import 'package:domain/usecases/get_image_url_usecase.dart';
import 'package:domain/usecases/get_movie_cast_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/const.dart';
import 'package:presentation/screens/movie_details/data/movie_details_data.dart';
import 'package:presentation/screens/movie_details/movie_details_screen.dart';

abstract class MovieDetailsBloc implements Bloc<MovieDetailsData> {
  factory MovieDetailsBloc(
    GetImageUrlUseCase getImageUrlUseCase,
    GetMovieCastUseCase getMovieCastUseCase,
  ) =>
      _MovieDetailsBloc(
        getImageUrlUseCase,
        getMovieCastUseCase,
      );

  String? formatApiRuntime(int? runtime);

  String? getImageUrlById(String? id);

  Future<void> getCast(int movieId);

  void handleBackPressed();
}

class _MovieDetailsBloc extends BlocImpl<MovieDetailsData>
    implements MovieDetailsBloc {
  final GetImageUrlUseCase _getImageUrlUseCase;
  final GetMovieCastUseCase _getMovieCastUseCase;

  _MovieDetailsBloc(
    this._getImageUrlUseCase,
    this._getMovieCastUseCase,
  ) : super(initState: MovieDetailsData.init());

  @override
  void initState() {
    _updateMovieDetailsWithArgumentsData();
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
  String? getImageUrlById(String? id) {
    return id != null ? _getImageUrlUseCase(id) : id;
  }

  @override
  Future<void> getCast(int movieId) async {
    final params = GetMovieCastUsecaseParams(
      movieId,
      MovieDetailsScreenConfig.maxCastCount,
    );

    final cast = await _getMovieCastUseCase(params);

    final newState = MovieDetailsData(
      state.movieDetails,
      cast,
    );

    add(newState);
  }

  @override
  void handleBackPressed() {
    appNavigator.pop();
  }

  Future<void> _updateMovieDetailsWithArgumentsData() async {
    final arguments = appNavigator.currentPage()?.arguments;

    if (arguments != null) {
      final movieDetailsScreenArguments =
          arguments as MovieDetailsScreenArguments;

      final traktId = movieDetailsScreenArguments.movieDetails.traktId;

      if (traktId != null) {
        final getMovieCastUsecaseParams = GetMovieCastUsecaseParams(
          traktId,
          MovieDetailsScreenConfig.maxCastCount,
        );

        final movieCast = await _getMovieCastUseCase(getMovieCastUsecaseParams);

        final newState = MovieDetailsData(
          movieDetailsScreenArguments.movieDetails,
          movieCast,
        );

        add(newState);
      }
    }
  }
}
