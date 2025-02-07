import 'package:gym_log/config/db.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:sqflite/sqflite.dart';

class SessionRepository {
  late Database db;
  Future<int?> startSession(int userId) async {
    try {
      int? currentSessionId;
      db = await DB.instance.database;
      currentSessionId = await db.insert('session', {
        'user_id': userId,
        'start_time': DateTime.now().toString(),
      });
      return currentSessionId;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void>? finishSession(
      List<ExerciseModel> exerciseList, int currentSessionId) async {
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
          var bestSerie = exercise.series!
              .reduce((curr, next) => curr.weight > next.weight ? curr : next);
          await txn.insert('historic', {
            'repetitions': bestSerie.lastRepetitions,
            'greater_weight': bestSerie.weight,
            'exercise_id': exercise.id,
            'session_id': currentSessionId,
            'created_date': DateTime.now().toString(),
          });

          for (var serie in exercise.series!) {
            await txn.update(
                "series",
                {
                  'executed_repetitions': serie.repetitons,
                  'last_weight': serie.weight,
                },
                where: 'id = ?',
                whereArgs: [serie.id]);
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
