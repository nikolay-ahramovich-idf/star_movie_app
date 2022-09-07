import 'package:domain/entities/base_movie_entity.dart';
import 'package:get_it/get_it.dart';
import 'package:domain/usecases/get_coming_soon_movies_usecase.dart';
import 'package:domain/usecases/get_now_showing_movies_usecase.dart';
import 'package:presentation/bloc/base/bloc.dart';
import 'package:presentation/bloc/base/bloc_impl.dart';
import 'package:presentation/screens/home/data/home_data.dart';

abstract class HomeBloc implements Bloc<HomeData> {
  factory HomeBloc() => _HomeBloc(
        GetIt.I.get<GetNowShowingMoviesUseCase>(),
        GetIt.I.get<GetComingSoonMoviesUseCase>(),
      );

  Future<void> showNowShowingMovies();
  Future<void> showComingSoonMovies();
}

class _HomeBloc extends BlocImpl<HomeData> implements HomeBloc {
  final GetNowShowingMoviesUseCase _getNowShowingMoviesUseCase;
  final GetComingSoonMoviesUseCase _getComingSoonMoviesUseCase;

  _HomeBloc(
    this._getNowShowingMoviesUseCase,
    this._getComingSoonMoviesUseCase,
  ) : super(initState: const HomeData.init());

  @override
  void initState() {
    add(const HomeData.init());
    // showComingSoonMovies();
  }

  @override
  Future<void> showNowShowingMovies() async {
    final movies = await _getNowShowingMoviesUseCase();
    _updateHomeDataWithMovies(movies);
  }

  @override
  Future<void> showComingSoonMovies() async {
    final movies = await _getComingSoonMoviesUseCase();
    _updateHomeDataWithMovies(movies);
  }

  void _updateHomeDataWithMovies(List<BaseMovieEntity> movies) {
    final newState = HomeData(movies);
    add(newState);
  }
}
