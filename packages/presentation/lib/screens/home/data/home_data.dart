import 'package:domain/entities/base_movie_entity.dart';

class HomeData {
  final List<BaseMovieEntity> _movies;

  const HomeData(this._movies);

  List<BaseMovieEntity> get movies => _movies;

  const HomeData.init() : _movies = const [];
}
