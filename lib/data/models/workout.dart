import 'package:gym_log/data/models/exercise.dart';

class WorkoutModel {
  int? id;
  String name;
  String muscleGroup;
  int userId;
  List<ExerciseModel> exercises;

  WorkoutModel(
      {this.id,
      required this.name,
      required this.muscleGroup,
      required this.userId,
      required this.exercises});
}
