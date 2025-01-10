import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:gym_log/data/models/exercise.dart';

import 'package:gym_log/data/models/workout.dart';
import 'package:gym_log/data/repositories/session_repository.dart';
import 'package:uuid/uuid.dart';

class SessionProvider extends ChangeNotifier {
  late WorkoutModel defaultWorkout;
  List<ExerciseModel> exerciseWithSeries = [];
  final SessionRepository sessionRepository = SessionRepository();
  int? currentSessionId;
  final uuid = const Uuid();
  void setDefaultWorkout(WorkoutModel workout) {
    defaultWorkout = workout;
    exerciseWithSeries.clear(); // Clear previous data
    exerciseWithSeries = workout.exercises;
    // for (var exercise in workout.exercises) {
    //   int countSeries = exercise.series!.length ?? 0;
    //   int countRepetition = exercise.series![0].defaultRepetitions ?? 0;

    //   List<SeriesSessionModel> exerciseSeries =
    //       List.generate(countSeries, (index) {
    //     return SeriesSessionModel(
    //       id: uuid.v4(),
    //       repetitions: countRepetition,
    //       weight: 0,
    //       checked: false,
    //       lastSession: exercise.lastSession ?? '0x0',
    //     );
    //   });

    //   exerciseWithSeries.add(ExerciseSeries(
    //     name: exercise.name,
    //     series: exerciseSeries,
    //     defaultRepetitions: countRepetition,
    //     lastSession: exercise.lastSession ?? '0x0',
    //   ));
    // }
    notifyListeners();
  }

  void addSeries(String exerciseName) {
    final exercise = exerciseWithSeries.firstWhere(
      (e) => e.name == exerciseName,
    );

    var serieExample = exercise.series!.last;

    exercise.series!.add(SeriesModel(
      id: Random().nextInt(100000),
      defaultRepetitions: serieExample.defaultRepetitions,
      lastRepetitions: 0,
      seriesIndex: exercise.series!.length + 1,
      lastWeight: serieExample.lastWeight,
      repetitons: 0,
      weight: 0,
    ));
    notifyListeners();
  }

  void removeSeries(String exerciseName, int serieId) {
    final exercise = exerciseWithSeries.firstWhere(
      (e) => e.name == exerciseName,
    );
    // print(
    //     "SERIE INDEX: $seriesIndex --------------------------------------------");
    // print("Antes de remover-----------------------");
    // for (var element in exercise.series) {
    //   print(element.repetitions);
    // }

    if (exercise.series!.isNotEmpty) {
      exercise.series!.removeLast();
    }

    notifyListeners();
    // print(
    //     "DEPOIS DE REMOVER-------------------------------------------------------");
    // for (var element in exercise.series) {
    //   print(element.repetitions);
    // }
  }

  void checkSeries(String exerciseName, int seriesIndex) {
    final exercise = exerciseWithSeries.firstWhere(
      (e) => e.name == exerciseName,
    );

    if (seriesIndex >= 0 && seriesIndex < exercise.series!.length) {
      exercise.series![seriesIndex].checked =
          (!exercise.series![seriesIndex].checked);
      notifyListeners();
    }
  }

  Future<void> startSession(int userId) async {
    currentSessionId = await sessionRepository.startSession(userId);
    notifyListeners();
  }

  Future<void> finishSession(List<ExerciseModel> exerciseList) async {
    if (currentSessionId != null) {
      await sessionRepository.finishSession(exerciseList, currentSessionId!);
      currentSessionId = null;
      notifyListeners();
    }
  }
}
