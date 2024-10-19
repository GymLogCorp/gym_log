import 'package:gym_log/models/exercise.dart';

class WorkoutModel {
  int id;
  String name;
  String muscleGroup;
  int userId;
  // int? sessionId;
  List<ExerciseModel> exercises;

  WorkoutModel(
      {required this.id,
      required this.name,
      required this.muscleGroup,
      required this.userId,
      // required this.sessionId,
      required this.exercises});

  String getSeriesRepsString() {
    return exercises
        .map(
            (exercise) => '${exercise.countSeries}x${exercise.countRepetition}')
        .join(', ');
  }
}
