import 'package:flutter/foundation.dart';
import 'package:gym_log/config/db.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:gym_log/data/models/workout.dart';
import 'package:sqflite/sqflite.dart';

class WorkoutRepository {
  late Database db;

  Future<List<WorkoutModel>> getWorkoutList(int userId) async {
    try {
      final db = await DB.instance.database;

      print("👍CHEGOU AQUI");

      List<Map<String, dynamic>> workoutList = await db.rawQuery(
        '''
    SELECT 
      workout.id AS workout_id, 
      workout.name AS workout_name, 
      workout.muscle_group AS workout_muscle_group, 
      workout.user_id AS workout_user_id,
      workout_exercise.id as workout_exercise_id,
      workout_exercise.workout_id AS workout_exercise_workout_id,
      workout_exercise.exercise_id AS workout_exercise_exercise_id,
      exercises.id AS exercise_id, 
      exercises.name AS exercise_name, 
      exercises.muscle_group AS exercise_muscle_group, 
      exercises.isCustom AS exercise_isCustom,
      series.series_index AS series_index,
      series.default_repetitions AS default_repetitions,
      series.last_weight AS last_weight,
      series.executed_repetitions AS executed_repetitions,
      series.id as series_id,
      series.workout_exercise_id as series_workout_exercise_id
    FROM workout_exercise
    INNER JOIN workout ON workout_exercise.workout_id = workout.id
    INNER JOIN exercises ON workout_exercise.exercise_id = exercises.id
    INNER JOIN series ON workout_exercise.id = series.workout_exercise_id
    WHERE workout.user_id = ?
    ''',
        [userId],
      );

      Map<int, WorkoutModel> workoutMap = {};
      for (var row in workoutList) {
        int workoutId = row['workout_id']; // ID do treino
        print("aqui  $workoutId");
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

        int exerciseId = row['exercise_id'];
        var workout = workoutMap[workoutId]!;

        ExerciseModel? existingExercise;

        try {
          existingExercise = workout.exercises.firstWhere(
            (exercise) => exercise.id == exerciseId,
          );
        } catch (e) {
          // Caso não encontre, deixa como null
          existingExercise = null;
        }

        if (existingExercise == null) {
          existingExercise = ExerciseModel(
            id: exerciseId,
            name: row['exercise_name'],
            muscleGroup: row['exercise_muscle_group'],
            isCustom: row['exercise_isCustom'] == 1,
            lastSession:
                '${row['last_weight'] ?? 0}x${row['default_repetitions'] ?? 0}',
            series: [],
          );
          workout.exercises.add(existingExercise);
        }

        SeriesModel? existingSeries;

        int seriesId = row['series_id'];
        try {
          print('${row["series_id"]}, '
              '${row["series_index"]}, '
              '${row["default_repetitions"]}, '
              '${row["executed_repetitions"]}, '
              '${row["last_weight"]}');
          existingSeries = existingExercise.series!.firstWhere(
            (series) => series.id == row['series_id'],
          );
        } catch (e) {
          existingSeries = null;
        }
        // workoutMap.values.toList().forEach((element) {
        //   debugPrint("💠 ${element}", wrapWidth: 1024);
        // });

        if (existingSeries == null) {
          existingExercise.series!.add(
            SeriesModel(
              id: seriesId,
              seriesIndex: row['series_index'],
              defaultRepetitions: row['default_repetitions'] ?? 0,
              lastRepetitions: row['executed_repetitions'] ?? 0,
              weight: 0,
              repetitons: 0,
              lastWeight: row['last_weight'],
            ),
          );
        }
      }

      workoutMap.values.toList().forEach((element) {
        debugPrint("✅ ${element}", wrapWidth: 1024);
      });
      return workoutMap.values.toList();
    } catch (e) {
      print(e);
      return [];
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

        for (var exercise in workout.exercises) {
          var response = await txn.insert('workout_exercise', {
            'workout_id': workoutId,
            'exercise_id': exercise.id,
          });

          for (var i = 0; i < (exercise.series!.length); i++) {
            await txn.insert('series', {
              'workout_exercise_id': response,
              'default_repetitions': exercise.series![i].defaultRepetitions,
              'series_index': i + 1,
              'last_weight': 0,
            });
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateWorkout(WorkoutModel workout) async {
    try {
      final db = await DB.instance.database;
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
              var workoutExercise = await txn.query(
                'workout_exercise',
                where: 'exercise_id = ? AND workout_id = ?',
                whereArgs: [exerciseId, workout.id],
              );

              if (workoutExercise.isNotEmpty) {
                Object? workoutExerciseId = workoutExercise.first['id'];
                await txn.delete(
                  'series',
                  where: 'workout_exercise_id = ?',
                  whereArgs: [workoutExerciseId],
                );
                await txn.delete(
                  'workout_exercise',
                  where: 'exercise_id = ? AND workout_id = ?',
                  whereArgs: [exerciseId, workout.id],
                );
              }
            }
          }

          for (var exercise in workout.exercises) {
            var response = await txn.insert(
              'workout_exercise',
              {
                'exercise_id': exercise.id,
                'workout_id': workout.id,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );

            await txn.delete(
              'series',
              where: 'workout_exercise_id = ?',
              whereArgs: [response],
            );

            for (var i = 0; i < (exercise.series!.length); i++) {
              await txn.insert('series', {
                'workout_exercise_id': response,
                'default_repetitions': exercise.series![i].defaultRepetitions,
                'series_index': i + 1,
                'last_weight': 0,
              });
            }
          }
        });
      }
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
          await txn.delete('series',
              where:
                  "workout_exercise_id IN (SELECT id FROM workout_exercise WHERE workout_id= ?)",
              whereArgs: [id]);

          await txn.delete('workout_exercise',
              where: "workout_id= ?", whereArgs: [id]);

          await txn.delete('workout', where: "id= ?", whereArgs: [id]);
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
