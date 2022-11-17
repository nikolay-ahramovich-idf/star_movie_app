import 'package:domain/entities/movie_character_entity.dart';

class CastCrewData {
  final List<MovieCharacterEntity>? _cast;

  CastCrewData(
    this._cast,
  );

  CastCrewData.init() : _cast = null;

  List<MovieCharacterEntity>? get cast => _cast;
}
