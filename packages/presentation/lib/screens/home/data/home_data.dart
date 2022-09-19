import 'package:domain/entities/base_movie_entity.dart';

enum SelectedMoviesType {
  nowShowing,
  comingSoon,
}

class HomeData {
  final Iterable<BaseMovieEntity> _movies;
  final SelectedMoviesType _selectedMovieType;

  const HomeData(
    this._movies,
    this._selectedMovieType,
  );

  List<BaseMovieEntity> get movies => _movies.toList();
  SelectedMoviesType get selectedMovieType => _selectedMovieType;

  const HomeData.init()
      : _movies = const [],
        _selectedMovieType = SelectedMoviesType.nowShowing;
}
