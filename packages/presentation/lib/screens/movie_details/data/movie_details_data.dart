import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movie_character_entity.dart';

class MovieDetailsData {
  final BaseMovieEntity? _movieDetails;
  final String? _formattedRuntime;
  final List<MovieCharacterEntity>? _cast;

  MovieDetailsData(
    this._movieDetails,
    this._formattedRuntime,
    this._cast,
  );

  MovieDetailsData.init()
      : _movieDetails = null,
        _formattedRuntime = null,
        _cast = null;

  BaseMovieEntity? get movieDetails => _movieDetails;

  String? get formattedRuntime => _formattedRuntime;

  List<MovieCharacterEntity>? get cast => _cast;
}
