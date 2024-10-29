import 'package:flutter/foundation.dart';
import 'package:gym_log/config/db.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:sqflite/sqflite.dart';

class SessionRepository extends ChangeNotifier {
  late Database db;
  int? currentSessionId;
  Future<void>? startSession(String userId) async {
    try {
      db = await DB.instance.database;
      currentSessionId = await db.insert('session', {
        'id_user': userId,
        'start_time': DateTime.now().toString(),
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void>? finishSession(List<ExerciseModel> exerciseList) async {
    try {
      db = await DB.instance.database;
      await db.transaction((txn) async {
        await txn.update(
            'session',
            {
              'end_time': DateTime.now().toString(),
            },
            where: "id= ?",
            whereArgs: [currentSessionId]);

        for (var exercise in exerciseList) {
          var idSessionExercise = await txn.insert('session_exercise', {
            'series': exercise.countSeries,
            'repetitions': exercise.countRepetition,
            'weight': exercise.weight,
            'id_exercise': exercise.id,
            'id_session': currentSessionId
          });

          await db.insert('historic_log', {
            'moment_repetitions': exercise.countRepetition,
            'moment_weight': exercise.weight,
            'created_date': DateTime.now().toString(),
            'id_session_exercise': idSessionExercise
          });
        }
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
