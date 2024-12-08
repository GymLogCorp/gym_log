import 'package:gym_log/data/models/historic_log.dart';

final List<ExerciseToHistoricModel> exerciseHistoryMock = [
  ExerciseToHistoricModel(
    name: 'Supino Reto',
    chartData: [
      ChartDataModel(weight: '60kg', date: '10-01'),
      ChartDataModel(weight: '55kg', date: '10-15'),
      ChartDataModel(weight: '65kg', date: '11-01'),
      ChartDataModel(weight: '70kg', date: '11-08'),
    ],
  ),
  ExerciseToHistoricModel(
    name: 'Agachamento',
    chartData: [
      ChartDataModel(weight: '80kg', date: '09-20'),
      ChartDataModel(weight: '85kg', date: '10-05'),
      ChartDataModel(weight: '90kg', date: '10-20'),
      ChartDataModel(weight: '300kg', date: '10-25'),
    ],
  ),
  ExerciseToHistoricModel(
    name: 'Rosca Direta',
    chartData: [
      ChartDataModel(weight: '20kg', date: '09-25'),
      ChartDataModel(weight: '22kg', date: '10-10'),
      ChartDataModel(weight: '25kg', date: '10-25'),
    ],
  ),
];
