class ExerciseModel {
  int id;
  String name;
  int? countSeries;
  int? countRepetition;
  String muscleGroup;
  bool isCustom;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.countSeries,
    required this.countRepetition,
    required this.muscleGroup,
    required this.isCustom,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'],
      name: map['name'],
      countSeries: 0,
      countRepetition: 0,
      muscleGroup: map['muscle_group'],
      isCustom: map['isCustom'] == 1 ? true : false,
    );
  }
}
