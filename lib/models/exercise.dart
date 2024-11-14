class ExerciseModel {
  int id;
  String name;
  int? countSeries;
  int? countRepetition;
  int? weight;
  String muscleGroup;
  bool isCustom;
  String? lastSession;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.countSeries,
    required this.countRepetition,
    required this.muscleGroup,
    required this.isCustom,
    this.lastSession,
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
  String name;
  List<ChartDataModel> chartData = [];

  ExerciseToHistoricModel({
    required this.name,
    required this.chartData,
  });
}

class ChartDataModel {
  final String weight;
  final String date;

  ChartDataModel({
    required this.weight,
    required this.date,
  });
}
