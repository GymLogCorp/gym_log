class ExerciseModel {
  int id;
  String name;
  int? countSeries;
  int? countRepetition;
  int? weight;
  String muscleGroup;
  bool isCustom;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.countSeries,
    required this.countRepetition,
    required this.muscleGroup,
    required this.isCustom,
    this.weight,
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

class ExerciseToHistoricModel {
  int id;
  String name;
  String momentRepetitions;
  String momentWeight;
  String createdDate;

  ExerciseToHistoricModel(
      {required this.id,
      required this.name,
      required this.momentRepetitions,
      required this.momentWeight,
      required this.createdDate});
}
