import 'package:gym_log/config/db.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseRepository {
  late Database db;
  List<ExerciseModel> exerciseList = [];

  Future<List<ExerciseModel>> getExerciseList(String muscle) async {
    try {
      db = await DB.instance.database;
      List<Map<String, dynamic>> response = await db
          .query('exercises', where: "muscle_group= ?", whereArgs: [muscle]);
      List<ExerciseModel> data = [];
      if (response.isNotEmpty) {
        for (var item in response) {
          ExerciseModel exercise = ExerciseModel.fromMap(item);
          data.add(exercise);
        }
      }
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ExerciseModel>> searchExerciseListByName(String name) async {
    try {
      db = await DB.instance.database;
      List<Map<String, dynamic>> response = await db.rawQuery('''
          SELECT * FROM exercises 
          WHERE name LIKE '%$name%' 
          AND id IN (SELECT exercise_id FROM historic)
          ''');
      List<ExerciseModel> data = [];
      if (response.isNotEmpty) {
        for (var item in response) {
          ExerciseModel exercise = ExerciseModel.fromMap(item);
          data.add(exercise);
        }
        return data;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> createCustomExercise(String name, String muscleGroup) async {
    try {
      final db = await DB.instance.database;
      await db.insert('exercises', {
        'name': name,
        'muscle_group': muscleGroup,
        'isCustom': 1,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCustomExercise(String id) async {
    try {
      final db = await DB.instance.database;
      await db.delete(
        'exercises',
        where: "id= ?",
        whereArgs: [id],
      );
    } catch (e) {
      print(e);
    }
  }
}
