import 'dart:async';
import 'package:data/database/dao/genre_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:data/database/dao/movie_dao.dart';
import 'package:data/database/entities/movie.dart';
import 'package:data/database/entities/genre.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Movie, Genre])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
  GenreDao get genreDao;
}
