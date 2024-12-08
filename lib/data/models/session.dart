class SessionModel {
  int id;
  String observation;
  String durationTime;
  String startTime;
  String endTime;

  SessionModel({
    required this.id,
    required this.observation,
    required this.durationTime,
    required this.startTime,
    required this.endTime,
  });
}

class SeriesModel {
  int repetitions;
  double weight;
  bool checked;
  String lastSession;
  String id;

  SeriesModel({
    required this.id,
    required this.repetitions,
    required this.weight,
    required this.checked,
    required this.lastSession,
  });
}

class ExerciseSeries {
  String name;
  int defaultRepetitions;
  String lastSession;
  List<SeriesModel> series;

  ExerciseSeries({
    required this.name,
    required this.defaultRepetitions,
    required this.lastSession,
    required this.series,
  });
}
