import 'package:path/path.dart';
import 'package:ppb_ets_2024/model/film.dart';
import 'package:sqflite/sqflite.dart';

class FilmDatabase {
  static final FilmDatabase instance = FilmDatabase._init();

  static Database? _database;

  FilmDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'films.db');

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);

    return _database!;
  }

  Future _onCreate(Database db, int version) async {
    const textType = 'TEXT NOT NULL';
    await db.execute('''
CREATE TABLE $tableFilms (
      ${FilmFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${FilmFields.title} $textType,
      ${FilmFields.imageUrl} $textType,
      ${FilmFields.description} $textType,
      ${FilmFields.time} $textType
      )
      ''');
  }

  Future<Film> create(Film film) async {
    final db = await instance.database;

    final id = await db.insert(tableFilms, film.toJson());
    return film.copy(id: id);
  }

  Future<int> update(Film film) async {
    final db = await instance.database;

    return db.update(
      tableFilms,
      film.toJson(),
      where: '${FilmFields.id} = ?',
      whereArgs: [film.id],
    );
  }

  Future<Film> readFilm(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFilms,
      columns: FilmFields.values,
      where: '${FilmFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Film.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Film>> readAllFilms() async {
    final db = await instance.database;

    const orderBy = '${FilmFields.time} ASC';
    final result = await db.query(tableFilms, orderBy: orderBy);

    return result.map((json) => Film.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
