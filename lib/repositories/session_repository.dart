import 'package:flutter/foundation.dart';
import 'package:gym_log/config/db.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:sqflite/sqflite.dart';

class SessionRepository extends ChangeNotifier {
  late Database db;
  int? currentSessionId;
  Future<void>? startSession(int userId) async {
    try {
      db = await DB.instance.database;
      currentSessionId = await db.insert('session', {
        'user_id': userId,
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
          var abacaxi = await txn.insert('historic', {
            'series': exercise.countSeries,
            'repetitions': exercise.countRepetition,
            'weight': exercise.weight,
            'exercise_id': exercise.id,
            'session_id': currentSessionId,
            'created_date': DateTime.now().toString(),
          });
          print(exercise.id);
          print(exercise.name);
        }
      });
      currentSessionId = null;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
