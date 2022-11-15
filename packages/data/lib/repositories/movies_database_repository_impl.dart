import 'package:data/database/dao/genre_dao.dart';
import 'package:data/database/dao/movie_character_dao.dart';
import 'package:data/database/dao/movie_dao.dart';
import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/db/genre.dart';
import 'package:domain/entities/db/movie.dart';
import 'package:domain/entities/db/movie_character.dart';
import 'package:domain/repositories/movies_database_repository.dart';

class MoviesDatabaseRepositoryImpl implements MoviesDatabaseRepository {
  final MovieDao _movieDao;
  final GenreDao _genreDao;
  final MovieCharacterDao _movieCharacterDao;

  MoviesDatabaseRepositoryImpl(
    this._movieDao,
    this._genreDao,
    this._movieCharacterDao,
  );

  @override
  Future<List<Movie>> getMovies(MoviesType movieType) async {
    return await _movieDao.findMoviesByType(movieType.index);
  }

  @override
  Future<void> addMovies(
    List<Movie> movies,
    List<Genre> genres,
  ) async {
    await _movieDao.insertMoviesWithGenres(
      movies,
      genres,
    );
  }

  @override
  Future<void> removeMoviesWithIds(List<int> movieIds) async {
    await _movieDao.deleteMoviesWithIds(movieIds);
  }

  @override
  Future<List<Genre>> getGenres(
    List<int> moviesIds,
  ) async {
    return await _genreDao.findMoviesGenres(moviesIds);
  }

  @override
  Future<void> addCastAndCrew(
    List<MovieCharacter> cast,
  ) async {
    await _movieCharacterDao.insertCast(cast);
  }

  @override
  Future<List<MovieCharacter>> getCastAndCrew(int movieId) async {
    return await _movieCharacterDao.findMovieCast(movieId);
  }
}
