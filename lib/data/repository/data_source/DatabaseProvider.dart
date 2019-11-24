import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider databaseProvider = DatabaseProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'notes.db'),
        version: 1,
        onOpen: (db) { },
        onCreate: (Database db, int version) async {
          await db.execute(" CREATE TABLE notes ("
              "id INTEGER PRIMARY KEY,"
              "title TEXT,"
              "body TEXT");
        });
  }}