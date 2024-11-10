import 'package:flutter/foundation.dart';
import 'package:gym_log/config/db.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HistoricRepository extends ChangeNotifier {
  late Database db;
  List<ExerciseToHistoricModel> historicExercisesList = [];

  Future<void> getHistoricByExercise(
      String exerciseId, String exerciseName) async {
    try {
      db = await DB.instance.database;
      historicExercisesList.clear();
      var response = await db
          .query('historic', where: 'exercise_id= ?', whereArgs: [exerciseId]);

      List<ChartDataModel> tempChartData = [];
      for (var row in response) {
        DateTime createdDate = DateTime.parse(row['created_date'] as String);
        String formattedDate = DateFormat('dd/MM').format(createdDate);
        tempChartData.add(ChartDataModel(
            weight: row['weight'] as String, date: formattedDate));
      }

      historicExercisesList.add(ExerciseToHistoricModel(
          name: exerciseName, chartData: tempChartData));
    } catch (e) {
      print(e);
    }
  }

  //receber a lista de exercícios do treino, passar por cada exercício, buscando o histórico e adicionando a lista

  Future<void> getExerciseHistoricListByWorkout(
      List<ExerciseModel> exerciseList) async {
    try {
      db = await DB.instance.database;
      historicExercisesList.clear();
      await db.transaction((txn) async {
        for (var exercise in exerciseList) {
          var historicExercise = await txn.query(
            'historic',
            where: "exercise_id= ?",
            whereArgs: [exercise.id],
          );
          List<ChartDataModel> tempChartData = [];
          for (var row in historicExercise) {
            DateTime createdDate =
                DateTime.parse(row['created_date'] as String);
            String formattedDate = DateFormat('dd/MM').format(createdDate);
            tempChartData.add(ChartDataModel(
                weight: row['weight'] as String, date: formattedDate));
          }
          historicExercisesList.add(ExerciseToHistoricModel(
            name: exercise.name,
            chartData: tempChartData,
          ));
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
