import 'package:flutter/foundation.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:gym_log/data/repositories/exercise_repository.dart';

class ExerciseProvider extends ChangeNotifier {
  List<ExerciseModel> exerciseList = [];
  final ExerciseRepository _exerciseRepository = ExerciseRepository();

  Future<void> getExerciseList(String muscle) async {
    exerciseList = await _exerciseRepository.getExerciseList(muscle);
    notifyListeners();
  }

  Future<void> searchExerciseListByName(String name) async {
    exerciseList = await _exerciseRepository.searchExerciseListByName(name);
    notifyListeners();
  }

  Future<void> createCustomExercise(String name, String muscleGroup) async {
    await _exerciseRepository.createCustomExercise(name, muscleGroup);
    notifyListeners();
  }

  Future<void> deleteCustomExercise(String id) async {
    await _exerciseRepository.deleteCustomExercise(id);
    notifyListeners();
  }
}
