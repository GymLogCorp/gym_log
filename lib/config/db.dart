import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  // esta classe vai gerenciar sua própria instância
  DB._(); // construtor com acesso privado

  static final DB instance = DB._(); // criando a instância do DB

  static Database? _database; // Instância do sqlite

  Future<Database> get database async {
    if (_database != null)
      return _database!; //caso o database exista ele já retorna, se não inicia outro

    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'gymlog.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_users);
    await db.execute(_session);
    await db.execute(_workout);
    await db.execute(_exercises);
    await db.execute(_historic_log);
  }

  String get _users => '''
  CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fullName TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
  );
  ''';

  String get _session => '''
  CREATE TABLE session (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    observation TEXT,
    duration_time TEXT NOT NULL,
    start_time TEXT NOT NULL,
    end_time TEXT NOT NULL
  );
  ''';

  String get _workout => '''
  CREATE TABLE workout (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   name TEXT NOT NULL,
   muscle_group TEXT NOT NULL,
   id_user INTEGER,
   id_session INTEGER,
   FOREIGN KEY (id_user) REFERENCES users(id),
   FOREIGN KEY (id_session) REFERENCES session(id)
  );
  ''';

  String get _exercises => '''
  CREATE TABLE exercises (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL, 
    count_series INTEGER,
    count_repetition INTEGER,
    weight TEXT,
    id_workout INTEGER,
    FOREIGN KEY (id_workout) REFERENCES workout(id)
  );
  ''';

  String get _historic_log => '''
  CREATE TABLE historic_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    exercises_register TEXT,
    moment_repetition TEXT,
    moment_weight TEXT,
    created_date TEXT,
    id_exercise INTEGER,
    FOREIGN KEY (id_exercise) REFERENCES exercises(id) 
  );
  ''';
}
