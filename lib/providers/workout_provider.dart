import 'package:flutter/foundation.dart';
import 'package:gym_log/data/models/workout.dart';
import 'package:gym_log/data/repositories/workout_repository.dart';

class WorkoutProvider extends ChangeNotifier {
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  List<WorkoutModel> workoutList = [];

  Future<void> getWorkoutList(int userId) async {
    workoutList = await _workoutRepository.getWorkoutList(userId);
    notifyListeners();
  }

  Future<void> addWorkout(WorkoutModel workout) async {
    await _workoutRepository.createWorkout(workout);
    notifyListeners();
  }

  Future<void> updateWorkout(WorkoutModel workout) async {
    await _workoutRepository.updateWorkout(workout);
    notifyListeners();
  }

  Future<void> deleteWorkout(int workoutId) async {
    await _workoutRepository.deleteWorkoutById(workoutId);
    notifyListeners();
  }
}
