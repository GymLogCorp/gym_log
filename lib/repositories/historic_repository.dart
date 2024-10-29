import 'package:flutter/foundation.dart';
import 'package:gym_log/config/db.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:sqflite/sqflite.dart';

class HistoricRepository extends ChangeNotifier {
  late Database db;
  List<ExerciseToHistoricModel> exerciseHistoricList = [];

  Future<void> getExerciseHistoricListByWorkout(String workoutId) async {
    try {
      db = await DB.instance.database;

      await db.transaction((txn) async {
        List<Map<String, Object?>> exerciseList = await txn.query(
          'workout_exercise',
          where: "id_workout= ?",
          whereArgs: [workoutId],
          columns: ['id_exercise'],
        );

        for (var exercise in exerciseList) {
          var sessionExerciseId = await txn.query(
            'session_exercise',
            where: "id_exercise= ?",
            whereArgs: [exercise['id_exercise']],
          );

          var response = await txn.query('historic_log',
              where: 'id_session_exercise= ?', whereArgs: [sessionExerciseId]);
          for (var row in response) {
            exerciseHistoricList.add(ExerciseToHistoricModel(
              id: row['id'],
              name: exercise.name,
              momentRepetitions: row['moment_repetitions'],
              momentWeight: row['moment_weight'],
              createdDate: row['created_date'],
            ));
          }
        }
      });
    } catch (e) {}
  }
}
