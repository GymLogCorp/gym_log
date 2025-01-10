import 'package:gym_log/config/db.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HistoricRepository {
  late Database db;

  Future<List<ExerciseToHistoricModel>> getHistoricByExercise(
      String exerciseId, String exerciseName) async {
    try {
      List<ExerciseToHistoricModel> data = [];
      db = await DB.instance.database;
      var response = await db.query('historic',
          where: 'exercise_id= ?', whereArgs: [exerciseId], limit: 5);
      List<ChartDataModel> tempChartData = [];
      for (var row in response) {
        DateTime createdDate = DateTime.parse(row['created_date'] as String);
        String formattedDate = DateFormat('dd/MM').format(createdDate);
        tempChartData.add(ChartDataModel(
            weight: (row['greater_weight'] as int), date: formattedDate));
        //weight: row['weight'] as String
      }

      data.add(ExerciseToHistoricModel(
          name: exerciseName, chartData: tempChartData));
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  //receber a lista de exercícios do treino, passar por cada exercício, buscando o histórico e adicionando a lista

  Future<List<ExerciseToHistoricModel>> getExerciseHistoricListByWorkout(
      List<ExerciseModel> exerciseList) async {
    try {
      db = await DB.instance.database;
      List<ExerciseToHistoricModel> data = [];
      await db.transaction((txn) async {
        for (var exercise in exerciseList) {
          var historicExercise = await txn.query('historic',
              where: "exercise_id= ?",
              whereArgs: [exercise.id],
              limit: 5,
              orderBy: 'created_date DESC'); // Get the last 5 records
          List<ChartDataModel> tempChartData = [];
          for (var row in historicExercise.reversed) {
            // Reverse to order from oldest to youngest
            DateTime createdDate =
                DateTime.parse(row['created_date'] as String);
            String formattedDate = DateFormat('dd/MM').format(createdDate);
            tempChartData.add(ChartDataModel(
                weight: row['greater_weight'] as int, date: formattedDate));
          }

          data.add(ExerciseToHistoricModel(
            name: exercise.name,
            chartData: tempChartData,
          ));
        }
      });
      return data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
