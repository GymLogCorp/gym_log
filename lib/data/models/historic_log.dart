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
