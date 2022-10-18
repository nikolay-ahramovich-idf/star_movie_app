import 'package:data/database/dao/genre_dao.dart';
import 'package:data/database/dao/movie_dao.dart';
import 'package:data/database/entities/genre.dart';
import 'package:data/database/entities/movie.dart';
import 'package:domain/entities/base_movie_entity.dart';
import 'package:domain/repositories/movies_database_repository.dart';

class MoviesDatabaseRepositoryImpl implements MoviesDatabaseRepository {
  final MovieDao _movieDao;
  final GenreDao _genreDao;

  MoviesDatabaseRepositoryImpl(
    this._movieDao,
    this._genreDao,
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
              movieId,
              genre,
            ),
          )
          .toList();

      if (genres != null) {
        await _genreDao.insertGenres(genres);
      }
    }
  }
}
