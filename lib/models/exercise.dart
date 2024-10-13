class ExerciseModel {
  int id;
  String name;
  int countSeries;
  int countRepetition;
  String? weight;
  int? workoutId;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.countSeries,
    required this.countRepetition,
    this.weight,
    this.workoutId,
  });
}
