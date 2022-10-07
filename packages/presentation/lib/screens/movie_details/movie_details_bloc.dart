import 'package:domain/entities/share_movie_entity.dart';
import 'package:domain/usecases/get_image_url_usecase.dart';
import 'package:domain/usecases/get_movie_cast_usecase.dart';
import 'package:domain/usecases/share_movie_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/const.dart';
import 'package:presentation/screens/movie_details/data/movie_details_data.dart';
import 'package:presentation/screens/movie_details/movie_details_screen.dart';

abstract class MovieDetailsBloc
    implements Bloc<MovieDetailsScreenArguments, MovieDetailsData> {
  factory MovieDetailsBloc(
    GetImageUrlUseCase getImageUrlUseCase,
    GetMovieCastUseCase getMovieCastUseCase,
    ShareMovieUseCase shareMovieUseCase,
  ) =>
      _MovieDetailsBloc(
        getImageUrlUseCase,
        getMovieCastUseCase,
        shareMovieUseCase,
      );

  String? getImageUrlById(String? id);

  Future<void> shareMovie(
    String message,
    String locale,
    int tmdbId,
  );

  void handleBackPressed();
}

class _MovieDetailsBloc
    extends BlocImpl<MovieDetailsScreenArguments, MovieDetailsData>
    implements MovieDetailsBloc {
  final GetImageUrlUseCase _getImageUrlUseCase;
  final GetMovieCastUseCase _getMovieCastUseCase;
  final ShareMovieUseCase _shareMovieUseCase;

  _MovieDetailsBloc(
    this._getImageUrlUseCase,
    this._getMovieCastUseCase,
    this._shareMovieUseCase,
  ) : super(initState: MovieDetailsData.init());

  @override
  void initArgs(MovieDetailsScreenArguments args) {
    super.initArgs(args);

    _getCast(args);
  }

  @override
  String? getImageUrlById(String? id) {
    return id != null ? _getImageUrlUseCase(id) : id;
  }

  @override
  Future<void> shareMovie(
    String message,
    String locale,
    int tmdbId,
  ) async {
    final shareMovieEntity = ShareMovieEntity(
      message,
      locale: locale,
      tmdbId: tmdbId,
    );

    await _shareMovieUseCase(shareMovieEntity);
  }

  @override
  void handleBackPressed() {
    appNavigator.pop();
  }

  Future<void> _getCast(MovieDetailsScreenArguments args) async {
    final traktId = args.movieDetails.traktId;

    if (traktId != null) {
      final getMovieCastUsecaseParams = GetMovieCastUseCaseParams(
        traktId,
        MovieDetailsScreenConfig.maxCastCount,
      );

      final movieCast = await _getMovieCastUseCase(getMovieCastUsecaseParams);

      final newState = MovieDetailsData(
        args.movieDetails,
        _formatApiRuntime(args.movieDetails.runtime),
        movieCast,
      );

      add(newState);
    }
  }

  String? _formatApiRuntime(int? runtime) {
    if (runtime == null) return null;
    const minutesInHour = 60;
    final minutes = runtime % minutesInHour;
    final hours = (runtime - minutes) ~/ minutesInHour;
    return '${hours}hr ${minutes}m';
  }
}
