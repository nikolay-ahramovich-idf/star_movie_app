import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:data/database/dao/genre_dao.dart';
import 'package:data/database/dao/movie_character_dao.dart';
import 'package:data/database/dao/movie_dao.dart';
import 'package:data/database/entities/genre.dart';
import 'package:data/database/entities/movie.dart';
import 'package:data/database/entities/movie_character.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Movie, Genre, MovieCharacter])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
  GenreDao get genreDao;
  MovieCharacterDao get movieCharacterDao;
}
