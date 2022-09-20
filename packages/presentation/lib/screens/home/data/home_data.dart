import 'package:domain/entities/base_movie_entity.dart';

enum SelectedMoviesType {
  nowShowing,
  comingSoon,
}

class HomeData {
  final Iterable<BaseMovieEntity> _movies;
  final SelectedMoviesType _selectedMovieType;
  final bool _isLoading;

  const HomeData(
    this._movies,
    this._selectedMovieType,
    this._isLoading,
  );

  List<BaseMovieEntity> get movies => _movies.toList();
  SelectedMoviesType get selectedMovieType => _selectedMovieType;
  bool get isLoading => _isLoading;

  const HomeData.init()
      : _movies = const [],
        _selectedMovieType = SelectedMoviesType.nowShowing,
        _isLoading = false;

  HomeData copyWith({
    List<BaseMovieEntity>? movies,
    SelectedMoviesType? selectedMovieType,
    bool? isLoading,
  }) =>
      HomeData(
        movies ?? _movies,
        selectedMovieType ?? _selectedMovieType,
        isLoading ?? _isLoading,
      );
}
