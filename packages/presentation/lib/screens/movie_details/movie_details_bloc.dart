import 'package:get_it/get_it.dart';
import 'package:domain/usecases/get_movie_cast_usecase.dart';
import 'package:domain/usecases/convert_api_runtime_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/const.dart';
import 'package:presentation/extensions/string.dart';
import 'package:presentation/screens/movie_details/data/movie_details_data.dart';
import 'package:presentation/screens/movie_details/movie_details_screen.dart';

abstract class MovieDetailsBloc implements Bloc<MovieDetailsData> {
  factory MovieDetailsBloc() => _MovieDetailsBloc(
        GetIt.I.get<ConvertApiRuntimeUsecase>(),
        // GetIt.I.get<GetImageUrlUseCase>(), TODO remove or change
        GetIt.I.get<GetMovieCastUsecase>(), // TODO move usecases to DI level like in home bloc
      );

  String convertApiRuntime(int runtime);
  String? getImageUrlById(String? id);
  String getGenresPresentation(Iterable<String> genres);
  Future<void> getCast(int movieId);
  void goBack();
}

class _MovieDetailsBloc extends BlocImpl<MovieDetailsData>
    implements MovieDetailsBloc {
  final ConvertApiRuntimeUsecase _convertApiRuntimeUsecase;
  // final GetImageUrlUseCase _getImageUrlUseCase; // TODO check later
  final GetMovieCastUsecase _getMovieCastUsecase;

  _MovieDetailsBloc(
    this._convertApiRuntimeUsecase,
    // this._getImageUrlUseCase, TODO check later
    this._getMovieCastUsecase,
  ) : super(
          initState: MovieDetailsData.init(),
        );

  @override
  void initState() {
    _updateMovieDetailsWithArgumentsData();
  }

  @override
  String convertApiRuntime(int runtime) {
    return _convertApiRuntimeUsecase(runtime);
  }

  @override
  String? getImageUrlById(String? id) { // TODO remove later
    final imageUri = Uri(
      scheme: IMDBConfig.apiScheme,
      host: IMDBConfig.apiPath,
      queryParameters: {
        IMDBConfig.imdbApiKeyQueryName: 3834002.toString(),
        IMDBQueryParameters.imageQueryKey: id,
      },
    );

    return id == null ? null : imageUri.toString();
  }

  @override
  String getGenresPresentation(Iterable<String> genres) {
    return genres.map((g) => g.capitalize()).join(', ');
  }

  @override
  Future<void> getCast(int movieId) async {
    final params = GetMovieCastUsecaseParams(
        movieId, MovieDetailsScreenConfig.maxCastCount);

    final cast = await _getMovieCastUsecase(params);

    final newState = MovieDetailsData(state.movieDetails, cast);

    add(newState);
  }

  @override
  void goBack() {
    appNavigator.pop();
  }

  Future<void> _updateMovieDetailsWithArgumentsData() async {
    final arguments = appNavigator.currentPage()?.arguments;

    if (arguments != null) {
      final movieDetailsScreenArguments =
          arguments as MovieDetailsScreenArguments;

      final getMovieCastUsecaseParams = GetMovieCastUsecaseParams(
        movieDetailsScreenArguments.movieDetails.traktId,
        MovieDetailsScreenConfig.maxCastCount,
      );

      final movieCast = await _getMovieCastUsecase(getMovieCastUsecaseParams);

      final newState = MovieDetailsData(
        movieDetailsScreenArguments.movieDetails,
        movieCast,
      );

      add(newState);
    }
  }
}
