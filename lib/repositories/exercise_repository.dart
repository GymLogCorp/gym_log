import 'package:flutter/foundation.dart';
import 'package:gym_log/config/db.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseRepository extends ChangeNotifier {
  late Database db;
  List<ExerciseModel> exerciseList = [];

  Future<void> getExerciseList(String muscle) async {
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
        exerciseList = data;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createCustomExercise(String name, String muscle_group) async {
    try {
      final db = await DB.instance.database;
      await db.insert('exercises', {
        'name': name,
        'muscle_group': muscle_group,
        'isCustom': 1,
      });
      notifyListeners();
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
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
