import 'dart:math';

import 'package:gym_log/config/default_exercises.dart';
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
    await db.execute(_user);
    await db.execute(_session);
    await db.execute(_workout);
    await db.execute(_exercise);
    await db.execute(_historicLog);
    await db.execute(_workout_exercise);
    await db.execute(_session_exercise);
    await insertDefaultExercises(db);
  }

  String get _user => '''
  CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fullName TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
  );
  ''';

  String get _session => '''
  CREATE TABLE session (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    observation TEXT,
    duration_time TEXT,
    start_time TEXT NOT NULL,
    end_time TEXT,
    id_user INTEGER NOT NULL,
    FOREIGN KEY (id_user) REFERENCES user(id)
  );
  ''';

  String get _workout => '''
  CREATE TABLE workout (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   name TEXT NOT NULL,
   muscle_group TEXT NOT NULL,
   id_user INTEGER NOT NULL,
   FOREIGN KEY (id_user) REFERENCES user(id)
  );
  ''';

  String get _exercise => '''
  CREATE TABLE exercises (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    muscle_group TEXT NOT NULL,
    isCustom INTEGER NOT NULL
  );
  ''';

  String get _historicLog => '''
  CREATE TABLE historic_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    moment_repetition INTEGER NOT NULL,
    moment_weight INTEGER NOT NULL,
    created_date TEXT NOT NULL,
    id_session_exercise INTEGER NOT NULL,
    FOREIGN KEY (id_session_exercise) REFERENCES session_exercise(id) 
  );
  ''';

  String get _workout_exercise => '''
  CREATE TABLE workout_exercise (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    default_series INTEGER NOT NULL,
    default_repetitions INTEGER NOT NULL,
    id_workout INTEGER NOT NULL,
    id_exercise INTEGER NOT NULL,
    FOREIGN KEY (id_workout) REFERENCES workout(id),
    FOREIGN KEY (id_exercise) REFERENCES exercise(id),
    UNIQUE(id_workout, id_exercise)
  );
  ''';

  String get _session_exercise => '''
  CREATE TABLE session_exercise (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    series INTEGER NOT NULL,
    repetitions INTEGER NOT NULL,
    weight INTEGER NOT NULL,
    id_session INTEGER NOT NULL,
    id_exercise INTEGER NOT NULL  ,
    FOREIGN KEY (id_session) REFERENCES session(id),
    FOREIGN KEY (id_exercise) REFERENCES exercise(id)
  );
  ''';

  Future<void> insertDefaultExercises(Database db) async {
    for (var muscleGroup in defaultExercises) {
      muscleGroup.forEach((muscle, exercises) async {
        for (var exercise in exercises) {
          print(
              '${exercise['name']} adicionado ao grupo ${muscle}'); // Debugging

          await db.insert('exercises', {
            'name': exercise['name'],
            'muscle_group': exercise['muscle'],
            'isCustom': 0
          });
        }
      });
    }
  }
}
