import 'package:get_it/get_it.dart';
import 'package:domain/usecases/get_image_url_usecase.dart';
import 'package:domain/usecases/get_movie_cast_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/const.dart';
import 'package:presentation/extensions/string.dart';
import 'package:presentation/screens/movie_details/data/movie_details_data.dart';
import 'package:presentation/screens/movie_details/movie_details_screen.dart';

abstract class MovieDetailsBloc implements Bloc<MovieDetailsData> {
  factory MovieDetailsBloc(GetImageUrlUsecase getImageUrlUsecase,
          GetMovieCastUsecase getMovieCastUsecase) =>
      _MovieDetailsBloc(
        getImageUrlUsecase,
        getMovieCastUsecase,
      );

  String? getImageUrlById(String? id);
  String getGenresPresentation(Iterable<String> genres);
  Future<void> getCast(int movieId);
  void goBack();
}

class _MovieDetailsBloc extends BlocImpl<MovieDetailsData>
    implements MovieDetailsBloc {
  final GetImageUrlUsecase _getImageUrlUsecase;
  final GetMovieCastUsecase _getMovieCastUsecase;

  _MovieDetailsBloc(
    this._getImageUrlUsecase,
    this._getMovieCastUsecase,
  ) : super(
          initState: MovieDetailsData.init(),
        );

  @override
  void initState() {
    _updateMovieDetailsWithArgumentsData();
  }

  @override
  String? getImageUrlById(String? id) {
    return id != null ? _getImageUrlUsecase(id) : id;
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
      final traktId = movieDetailsScreenArguments.movieDetails.traktId;
      if (traktId != null) {
        final getMovieCastUsecaseParams = GetMovieCastUsecaseParams(
          traktId,
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
}
