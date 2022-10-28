import 'package:domain/entities/db/movie_character.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieCharacterDao {
  @Query('SELECT * FROM MovieCharacter WHERE movieId = :movieId')
  Future<List<MovieCharacter>> findMovieCast(int movieId);

  @insert
  Future<void> insertCast(List<MovieCharacter> cast);
}
