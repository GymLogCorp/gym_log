import 'package:flutter/foundation.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:gym_log/data/repositories/historic_repository.dart';

class HistoricProvider extends ChangeNotifier {
  List<ExerciseToHistoricModel> historicExercisesList = [];
  final HistoricRepository _historicRepository = HistoricRepository();
  Future<void> getHistoricByExercise(
      String exerciseId, String exerciseName) async {
    historicExercisesList = await _historicRepository.getHistoricByExercise(
        exerciseId, exerciseName);
    notifyListeners();
  }

  Future<void> getExerciseHistoricListByWorkout(
      List<ExerciseModel> exerciseList) async {
    historicExercisesList = await _historicRepository
        .getExerciseHistoricListByWorkout(exerciseList);
    notifyListeners();
  }
}
