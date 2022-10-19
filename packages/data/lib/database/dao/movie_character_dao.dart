import 'package:data/database/entities/movie_character.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieCharacterDao {
  @Query('SELECT * FROM MovieCharacter WHERE movieId = :movieId')
  Future<List<MovieCharacter>> findMovieCast(int movieId);

  @Query('DELETE FROM MovieCharacter WHERE movieId NOT IN (:movieIds)')
  Future<void> deleteCastsExceptWithIds(List<int> movieIds);

  @insert
  Future<void> insertCast(List<MovieCharacter> cast);
}
