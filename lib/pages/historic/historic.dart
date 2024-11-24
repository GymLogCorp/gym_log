import 'package:flutter/material.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:gym_log/models/workout.dart';
import 'package:gym_log/pages/historic/historic_chart.dart';
import 'package:gym_log/repositories/historic_repository.dart';
import 'package:gym_log/repositories/workout_repository.dart';
import 'package:gym_log/resources/app_colors.dart';
import 'package:provider/provider.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  int selectedExerciseIndex = 0;
  List<int> showingTooltipOnSpots = [];
  late List<WorkoutModel> menuOptions;
  WorkoutModel? workoutSelected;
  @override
  void initState() {
    super.initState();
    menuOptions =
        Provider.of<WorkoutRepository>(context, listen: false).workoutList;
    getHistoricByWorkout(menuOptions.first);
    workoutSelected = menuOptions.first;
  }

  void getHistoricByWorkout(WorkoutModel workout) async {
    await Provider.of<HistoricRepository>(context, listen: false)
        .getExerciseHistoricListByWorkout(workout.exercises);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<WorkoutModel>(
          value: workoutSelected,
          style: const TextStyle(color: Colors.white),
          onChanged: (WorkoutModel? workoutSelected) {
            if (workoutSelected != null) {
              setState(() {
                this.workoutSelected = workoutSelected;
              });
              getHistoricByWorkout(workoutSelected);
            }
          },
          items: menuOptions
              .map<DropdownMenuItem<WorkoutModel>>((WorkoutModel item) {
            return DropdownMenuItem(
                value: item,
                child: Text(
                  item.name,
                  style: const TextStyle(color: AppColors.contentColorBlue),
                ));
          }).toList(),
        ),
        Consumer<HistoricRepository>(
          builder: (context, historicRepository, child) {
            if (historicRepository.historicExercisesList.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum dado encontrado.',
                  style: TextStyle(
                    color: AppColors.contentColorBlue,
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              List<ChartDataModel> chartData = historicRepository
                  .historicExercisesList[selectedExerciseIndex].chartData;

              if (chartData.isEmpty || chartData.length == 1) {
                return const Center(
                  child: Text(
                    'Nenhum dado encontrado.',
                    style: TextStyle(
                      color: AppColors.contentColorBlue,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              // return Center(
              //   child: HistoricChart(chartData: chartData),
              // );
              return Column(
                children: historicRepository.historicExercisesList
                    .map((exercise) => Column(
                          children: [
                            Text(
                              exercise.name,
                              style: const TextStyle(
                                color: AppColors.contentColorBlue,
                                fontSize: 16,
                              ),
                            ),
                            HistoricChart(chartData: exercise.chartData),
                          ],
                        ))
                    .toList(),
              );
            }
          },
        )
      ],
    );
  }
}
