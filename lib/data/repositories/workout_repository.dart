import 'package:flutter/foundation.dart';
import 'package:gym_log/config/db.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:gym_log/data/models/workout.dart';
import 'package:sqflite/sqflite.dart';

class WorkoutRepository extends ChangeNotifier {
  late Database db;
  List<WorkoutModel> workoutList = [];

  Future<void> getWorkoutList(int userId) async {
    try {
      final db = await DB.instance.database;
      List<Map<String, dynamic>> response = await db.rawQuery(
        '''
    SELECT 
      workout.id AS workout_id, 
      workout.name AS workout_name, 
      workout.muscle_group AS workout_muscle_group, 
      workout.user_id AS workout_user_id,
      workout_exercise.*, 
      exercises.id AS exercise_id, 
      exercises.name AS exercise_name, 
      exercises.muscle_group AS exercise_muscle_group, 
      exercises.isCustom AS exercise_isCustom,
      (SELECT h.repetitions 
     FROM historic h 
     WHERE h.exercise_id = exercises.id 
     ORDER BY h.created_date DESC 
     LIMIT 1) AS last_repetitions,
    (SELECT h.weight 
     FROM historic h 
     WHERE h.exercise_id = exercises.id 
     ORDER BY h.created_date DESC 
     LIMIT 1) AS last_weight
    FROM workout_exercise
    INNER JOIN workout ON workout_exercise.workout_id = workout.id
    INNER JOIN exercises ON workout_exercise.exercise_id = exercises.id
    WHERE workout.user_id = ?
    ''',
        [userId],
      );

      Map<int, WorkoutModel> workoutMap = {};

      for (var row in response) {
        int workoutId = row['workout_id']; // ID do treino
        // Verifica se o treino já foi adicionado ao mapa
        if (!workoutMap.containsKey(workoutId)) {
          workoutMap[workoutId] = WorkoutModel(
            id: workoutId,
            name: row['workout_name'],
            muscleGroup: row['workout_muscle_group'],
            userId: row['workout_user_id'],
            exercises: [],
          );
        }

        var lastSessionConcat =
            '${row['last_weight'] ?? 0}x${row['last_repetitions'] ?? 0}';

        // Adiciona o exercício ao treino correspondente
        workoutMap[workoutId]!.exercises.add(
              ExerciseModel(
                id: row['exercise_id'],
                name: row['exercise_name'], // Nome do exercício
                countSeries: row['default_series'],
                countRepetition: row['default_repetitions'],
                muscleGroup: row['exercise_muscle_group'],
                isCustom: row['exercise_isCustom'] == 1 ? true : false,
                lastSession: lastSessionConcat,
              ),
            );
      }
      workoutList = workoutMap.values.toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createWorkout(WorkoutModel workout) async {
    try {
      final db = await DB.instance.database;

      await db.transaction((txn) async {
        int workoutId = await txn.insert('workout', {
          'name': workout.name,
          'muscle_group': workout.muscleGroup,
          'user_id': workout.userId
        });
        print(workoutId);

        for (var exercise in workout.exercises) {
          await txn.insert('workout_exercise', {
            'workout_id': workoutId,
            'exercise_id': exercise.id,
            'default_series': exercise.countSeries,
            'default_repetitions': exercise.countRepetition,
          });
        }
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateWorkout(WorkoutModel workout) async {
    try {
      final db = await DB.instance.database;
      print(workout.id);
      var workoutIsExist = await db.query(
        'workout',
        where: "id= ?",
        whereArgs: [workout.id],
      );
      if (workoutIsExist.isEmpty) {
        throw Exception("Treino não encontrado.");
      } else {
        await db.transaction((txn) async {
          await txn.update(
            'workout',
            {
              'name': workout.name,
              'muscle_group': workout.muscleGroup,
            },
            where: "id= ?",
            whereArgs: [workout.id],
          );

          //Lógica para remover os atuais exercícios e depois colocar os novos

          List<Map<String, dynamic>> currentExercises = await txn.query(
            'workout_exercise',
            where: 'workout_id = ?',
            whereArgs: [workout.id],
          );

          List<int> currentExerciseIds =
              currentExercises.map((e) => e['exercise_id'] as int).toList();

          List<int> newExerciseIds =
              workout.exercises.map((e) => e.id).toList();

          for (var exerciseId in currentExerciseIds) {
            if (!newExerciseIds.contains(exerciseId)) {
              await txn.delete(
                'workout_exercise',
                where: 'exercise_id = ? AND workout_id = ?',
                whereArgs: [exerciseId, workout.id],
              );
            }
          }

          for (var exercise in workout.exercises) {
            await txn.insert(
              'workout_exercise',
              {
                'exercise_id': exercise.id,
                'workout_id': workout.id,
                'default_series': exercise.countSeries,
                'default_repetitions': exercise.countRepetition
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        });
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteWorkoutById(int id) async {
    try {
      final db = await DB.instance.database;
      var workoutIsExist = await db.query(
        'workout',
        where: "id= ?",
        whereArgs: [id],
      );
      if (workoutIsExist.isEmpty) {
        throw Exception("Treino não encontrado.");
      } else {
        await db.transaction((txn) async {
          await txn.delete('workout_exercise',
              where: "workout_id= ?", whereArgs: [id]);

          await txn.delete('workout', where: "id= ?", whereArgs: [id]);
        });
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
