import 'package:domain/entities/cast_crew_response_entity.dart';
import 'package:domain/entities/movies_response_entity.dart';

abstract class MoviesRepository {
  Future<MoviesResponseEntity> getNowShowingMovies([
    Map<String, dynamic> queryParameters,
  ]);

  Future<MoviesResponseEntity> getComingSoonMovies([
    Map<String, dynamic> queryParameters,
  ]);

  Future<CastCrewResponseEntity> getCastAndCrew(int movieId);
}
