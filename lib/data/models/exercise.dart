class ExerciseModel {
  int id;
  String name;
  String muscleGroup;
  bool isCustom;
  String? lastSession;
  List<SeriesModel>? series = [];

  ExerciseModel({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.isCustom,
    this.lastSession,
    this.series,
  });

  @override
  String toString() {
    return 'ExerciseModel{id: $id, name: $name, muscleGroup: $muscleGroup, isCustom: $isCustom, lastSession: $lastSession, series: $series}';
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'],
      name: map['name'],
      muscleGroup: map['muscle_group'],
      isCustom: map['isCustom'] == 1 ? true : false,
    );
  }
}

class SeriesModel {
  int? id;
  int seriesIndex;
  int defaultRepetitions;
  int lastRepetitions;
  int repetitons;
  int lastWeight;
  double weight;
  bool checked;

  SeriesModel(
      {this.id,
      required this.seriesIndex,
      required this.defaultRepetitions,
      required this.lastRepetitions,
      required this.lastWeight,
      this.checked = false,
      required this.weight,
      required this.repetitons});

  @override
  String toString() {
    return 'SeriesModel{seriesIndex: $seriesIndex, defaultRepetitions: $defaultRepetitions, executedRepetitions: $lastRepetitions, lastWeight: $lastWeight}';
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
  final int weight;
  final String date;

  ChartDataModel({
    required this.weight,
    required this.date,
  });
}
