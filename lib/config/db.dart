import 'package:gym_log/config/default_exercises.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DB {
  // esta classe vai gerenciar sua própria instância
  DB._(); // construtor com acesso privado

  static final DB instance = DB._(); // criando a instância do DB

  static Database? _database; // Instância do sqlite

  Future<Database> get database async {
    if (_database != null) {
      return _database!; //caso o database exista ele já retorna, se não inicia outro
    }

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
    await db.execute(_workoutExercise);
    await db.execute(_historic);
    await db.execute(_series);
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
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
  );
  ''';

  String get _workout => '''
  CREATE TABLE workout (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   name TEXT NOT NULL,
   muscle_group TEXT NOT NULL,
   user_id INTEGER NOT NULL,
   FOREIGN KEY (user_id) REFERENCES user(id)
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

  String get _workoutExercise => '''
  CREATE TABLE workout_exercise (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    workout_id INTEGER NOT NULL,
    exercise_id INTEGER NOT NULL,
    FOREIGN KEY (workout_id) REFERENCES workout(id),
    FOREIGN KEY (exercise_id) REFERENCES exercise(id),
    UNIQUE(workout_id, exercise_id)
  );
  ''';

  String get _series => '''
  CREATE TABLE series (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    series_index INTEGER NOT NULL,
    default_repetitions INTEGER NOT NULL,
    executed_repetitions INTEGER,
    last_weight INTEGER NOT NULL,
    workout_exercise_id INTEGER NOT NULL,
    FOREIGN KEY (workout_exercise_id) REFERENCES workout_exercise(id)
  );
  ''';

  String get _historic => '''
  CREATE TABLE historic (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    repetitions INTEGER NOT NULL,
    greater_weight INTEGER NOT NULL,
    created_date TEXT NOT NULL,
    session_id INTEGER NOT NULL,
    exercise_id INTEGER NOT NULL  ,
    FOREIGN KEY (session_id) REFERENCES session(id),
    FOREIGN KEY (exercise_id) REFERENCES exercise(id)
  );
  ''';

  Future<void> insertDefaultExercises(Database db) async {
    for (var muscleGroup in defaultExercises) {
      muscleGroup.forEach((muscle, exercises) async {
        for (var exercise in exercises) {
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
