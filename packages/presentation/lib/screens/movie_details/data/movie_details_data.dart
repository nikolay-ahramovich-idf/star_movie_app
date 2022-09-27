import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movie_character_entity.dart';

class MovieDetailsData {
  final BaseMovieEntity? _movieDetails;
  final List<MovieCharacterEntity>? _cast;

  MovieDetailsData(
    this._movieDetails,
    this._cast,
  );

  MovieDetailsData.init()
      : _movieDetails = null,
        _cast = null;

  BaseMovieEntity? get movieDetails => _movieDetails;

  List<MovieCharacterEntity>? get cast => _cast;
}
