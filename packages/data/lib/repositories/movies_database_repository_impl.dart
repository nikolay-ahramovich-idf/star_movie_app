import 'package:data/database/dao/genre_dao.dart';
import 'package:data/database/dao/movie_character_dao.dart';
import 'package:data/database/dao/movie_dao.dart';
import 'package:data/database/entities/genre.dart';
import 'package:data/database/entities/movie.dart';
import 'package:data/database/entities/movie_character.dart';
import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/entities/movie_character_entity.dart';
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
  Future<List<BaseMovieEntity>> getMovies(MovieType movieType) async {
    final movies = await _movieDao.findMoviesByType(movieType.index);

    final movieEntities = movies.map((movie) async {
      final genres = await _genreDao.findMovieGenres(movie.id!);
      final genreNames = genres
          .map(
            (genre) => genre.name,
          )
          .toList();

      return BaseMovieEntity(
        movie.title,
        rating: movie.rating,
        genres: genreNames,
        runtime: movie.runtime,
        certification: movie.certification,
        overview: movie.overview,
        traktId: movie.traktId,
        imdbId: movie.imdbId,
        tmdbId: movie.tmdbId,
      );
    });

    return Future.wait(movieEntities);
  }

  @override
  Future<void> addMovies(
    List<BaseMovieEntity> movies,
    MovieType moviesType,
  ) async {
    for (var movieEntity in movies) {
      final movie = Movie(
        title: movieEntity.title,
        rating: movieEntity.rating,
        runtime: movieEntity.runtime,
        certification: movieEntity.certification,
        overview: movieEntity.overview,
        traktId: movieEntity.traktId,
        imdbId: movieEntity.imdbId,
        tmdbId: movieEntity.tmdbId,
        moviesType: moviesType.index,
      );

      final movieId = await _movieDao.insertMovie(movie);

      final genres = movieEntity.genres
          ?.map(
            (genre) => Genre(
              movieId: movieId,
              name: genre,
            ),
          )
          .toList();

      if (genres != null) {
        await _genreDao.insertGenres(genres);
      }
    }
  }

  @override
  Future<void> removeMovies() async {
    await _movieDao.deleteAllMovies();
  }

  @override
  Future<void> addCast(
    int movieId,
    List<MovieCharacterEntity> cast,
  ) async {
    final List<MovieCharacter> castModel = [];

    for (final castItem in cast) {
      final movieCharacterModel = MovieCharacter(
        characterName: castItem.characterName,
        actorName: castItem.actorName,
        tmdbId: castItem.tmdbId,
        posterPath: castItem.posterPath,
        movieId: movieId,
      );

      castModel.add(movieCharacterModel);
    }

    await _movieCharacterDao.insertCast(castModel);
  }

  @override
  Future<List<MovieCharacterEntity>> getCast(int movieId) async {
    final cast = await _movieCharacterDao.findMovieCast(movieId);

    return cast
        .map(
          ((castItem) => MovieCharacterEntity(
                characterName: castItem.characterName,
                actorName: castItem.actorName,
                tmdbId: castItem.tmdbId,
                posterPath: castItem.posterPath,
              )),
        )
        .toList();
  }

  @override
  Future<void> removeCastExceptWithIds(List<int> movieIds) async {
    await _movieCharacterDao.deleteCastsExceptWithIds(movieIds);
  }
}
