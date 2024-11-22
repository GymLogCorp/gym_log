import 'package:flutter/foundation.dart';
import 'package:gym_log/models/session.dart';

import 'package:gym_log/models/workout.dart';
import 'package:uuid/uuid.dart';

class SessionState extends ChangeNotifier {
  late WorkoutModel defaultWorkout;
  List<ExerciseSeries> exerciseWithSeries = [];
  final uuid = const Uuid();
  void setDefaultWorkout(WorkoutModel workout) {
    defaultWorkout = workout;
    exerciseWithSeries.clear(); // Clear previous data

    for (var exercise in workout.exercises) {
      int countSeries = exercise.countSeries ?? 0;
      int countRepetition = exercise.countRepetition ?? 0;

      List<SeriesModel> exerciseSeries = List.generate(countSeries, (index) {
        return SeriesModel(
          id: uuid.v4(),
          repetitions: countRepetition,
          weight: 0,
          checked: false,
          lastSession: exercise.lastSession ?? '0x0',
        );
      });

      exerciseWithSeries.add(ExerciseSeries(
        name: exercise.name,
        series: exerciseSeries,
        defaultRepetitions: countRepetition,
        lastSession: exercise.lastSession ?? '0x0',
      ));
    }
    notifyListeners();
  }

  void addSeries(String exerciseName) {
    final exercise = exerciseWithSeries.firstWhere(
      (e) => e.name == exerciseName,
    );

    exercise.series.add(SeriesModel(
        id: uuid.v4(),
        repetitions: exercise.defaultRepetitions,
        weight: 0,
        checked: false,
        lastSession: exercise.lastSession));
    notifyListeners();
  }

  void removeSeries(String exerciseName, String serieId) {
    final exercise = exerciseWithSeries.firstWhere(
      (e) => e.name == exerciseName,
    );
    // print(
    //     "SERIE INDEX: $seriesIndex --------------------------------------------");
    // print("Antes de remover-----------------------");
    // for (var element in exercise.series) {
    //   print(element.repetitions);
    // }

    exercise.series.removeWhere((serie) => serie.id == serieId);

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

    if (seriesIndex >= 0 && seriesIndex < exercise.series.length) {
      exercise.series[seriesIndex].checked =
          (!exercise.series[seriesIndex].checked);
      notifyListeners();
    }
  }
}
