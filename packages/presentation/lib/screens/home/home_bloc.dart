import 'package:get_it/get_it.dart';
import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/usecases/convert_api_runtime_usecase.dart';
import 'package:domain/usecases/get_coming_soon_movies_usecase.dart';
import 'package:domain/usecases/get_now_showing_movies_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/const.dart';
import 'package:presentation/screens/home/data/home_data.dart';
import 'package:presentation/screens/movie_details/movie_details_screen.dart';

abstract class HomeBloc implements Bloc<HomeData?> {
  factory HomeBloc() => _HomeBloc(
        GetIt.I.get<GetNowShowingMoviesUseCase>(),
        GetIt.I.get<GetComingSoonMoviesUseCase>(),
        GetIt.I.get<ConvertApiRuntimeUsecase>(),
        // GetIt.I.get<GetImageUrlUseCase>(), // TODO restore withoout repository
      );

  Future<void> showNowShowingMovies();
  Future<void> showComingSoonMovies();
  String convertApiRuntime(int runtime);
  String? getImageUrlById(String? id);
  void goToMovieDetailsPage(BaseMovieEntity movieDetails);
}

class _HomeBloc extends BlocImpl<HomeData?> implements HomeBloc {
  final GetNowShowingMoviesUseCase _getNowShowingMoviesUseCase;
  final GetComingSoonMoviesUseCase _getComingSoonMoviesUseCase;
  final ConvertApiRuntimeUsecase _convertApiRuntimeUsecase;
  // final GetImageUrlUseCase _getImageUrlUseCase; TODO restore later

  _HomeBloc(
    this._getNowShowingMoviesUseCase,
    this._getComingSoonMoviesUseCase,
    this._convertApiRuntimeUsecase,
    // this._getImageUrlUseCase, // TODO restore later
  ) : super(initState: const HomeData.init());

  @override
  void initState() {
    showNowShowingMovies();
  }

  @override
  Future<void> showNowShowingMovies() async {
    add(null);
    final movies = await _getNowShowingMoviesUseCase();
    _updateHomeDataWithMovies(movies);
  }

  @override
  Future<void> showComingSoonMovies() async {
    add(null);
    final movies = await _getComingSoonMoviesUseCase();
    _updateHomeDataWithMovies(movies);
  }

  void _updateHomeDataWithMovies(List<BaseMovieEntity> movies) {
    final newState = HomeData(movies);
    add(newState);
  }

  @override
  String convertApiRuntime(int runtime) {
    return _convertApiRuntimeUsecase(runtime);
  }

  @override
  String? getImageUrlById(String? id) { // TODO check later
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
  void goToMovieDetailsPage(BaseMovieEntity movieDetails) {
    final movieDetailsScreenArguments = MovieDetailsScreenArguments(
      movieDetails: movieDetails,
    );

    appNavigator.push(
      MovieDetailsScreen.page(
        movieDetailsScreenArguments,
      ),
    );
  }
}
