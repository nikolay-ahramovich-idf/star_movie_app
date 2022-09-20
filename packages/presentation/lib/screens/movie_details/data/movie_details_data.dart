import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movie_character_entity.dart';
import 'package:presentation/screens/movie_details/movie_details_screen.dart';

class MovieDetailsData {
  final BaseMovieEntity? _movieDetails;
  final Iterable<MovieCharacterEntity>? _cast;

  MovieDetailsData(
    this._movieDetails,
    this._cast,
  );

  MovieDetailsData.init()
      : _movieDetails = null,
        _cast = null;

  BaseMovieEntity? get movieDetails => _movieDetails;

  List<MovieCharacterEntity> get cast =>
      (_cast as Iterable<MovieCharacterEntity>).toList();
}
