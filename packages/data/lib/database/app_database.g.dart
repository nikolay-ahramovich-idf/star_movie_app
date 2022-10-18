// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  GenreDao? _genreDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movie` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `rating` REAL, `runtime` INTEGER, `certification` TEXT, `overview` TEXT, `traktId` INTEGER, `imdbId` TEXT, `tmdbId` INTEGER, `moviesType` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Genre` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `movie_id` INTEGER NOT NULL, `name` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  GenreDao get genreDao {
    return _genreDaoInstance ??= _$GenreDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'rating': item.rating,
                  'runtime': item.runtime,
                  'certification': item.certification,
                  'overview': item.overview,
                  'traktId': item.traktId,
                  'imdbId': item.imdbId,
                  'tmdbId': item.tmdbId,
                  'moviesType': item.moviesType
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  @override
  Future<List<Movie>> findMoviesByType(int movieType) async {
    return _queryAdapter.queryList('SELECT * FROM Movie WHERE moviesType = ?1',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int?,
            title: row['title'] as String?,
            rating: row['rating'] as double?,
            runtime: row['runtime'] as int?,
            certification: row['certification'] as String?,
            overview: row['overview'] as String?,
            traktId: row['traktId'] as int?,
            imdbId: row['imdbId'] as String?,
            tmdbId: row['tmdbId'] as int?,
            moviesType: row['moviesType'] as int),
        arguments: [movieType]);
  }

  @override
  Future<void> deleteAllMovies() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Movie');
  }

  @override
  Future<int> insertMovie(Movie movie) {
    return _movieInsertionAdapter.insertAndReturnId(
        movie, OnConflictStrategy.abort);
  }
}

class _$GenreDao extends GenreDao {
  _$GenreDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _genreInsertionAdapter = InsertionAdapter(
            database,
            'Genre',
            (Genre item) => <String, Object?>{
                  'id': item.id,
                  'movie_id': item.movieId,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Genre> _genreInsertionAdapter;

  @override
  Future<List<Genre>> findMovieGenres(int movieId) async {
    return _queryAdapter.queryList('SELECT * FROM Genre WHERE movie_id = ?1',
        mapper: (Map<String, Object?> row) =>
            Genre(row['movie_id'] as int, row['name'] as String),
        arguments: [movieId]);
  }

  @override
  Future<void> insertGenres(List<Genre> genres) async {
    await _genreInsertionAdapter.insertList(genres, OnConflictStrategy.abort);
  }
}
