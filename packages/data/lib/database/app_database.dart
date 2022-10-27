import 'dart:async';

import 'package:data/const.dart';
import 'package:data/database/dao/genre_dao.dart';
import 'package:data/database/dao/movie_character_dao.dart';
import 'package:data/database/dao/movie_dao.dart';
import 'package:domain/entities/db/genre.dart';
import 'package:domain/entities/db/movie.dart';
import 'package:domain/entities/db/movie_character.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: DatabaseConfig.version, entities: [
  Movie,
  Genre,
  MovieCharacter,
])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
  GenreDao get genreDao;
  MovieCharacterDao get movieCharacterDao;
}
