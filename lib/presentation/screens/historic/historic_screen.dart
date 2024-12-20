import 'package:flutter/material.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:gym_log/data/models/workout.dart';
import 'package:gym_log/presentation/screens/historic/widgets/weight_chart.dart';
import 'package:gym_log/providers/historic_provider.dart';
import 'package:gym_log/providers/workout_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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

    var workoutList =
        Provider.of<WorkoutProvider>(context, listen: false).workoutList;
    if (workoutList.isNotEmpty) {
      menuOptions = workoutList;
      workoutSelected = menuOptions.first;
      getHistoricByWorkout(menuOptions.first);
    } else {
      menuOptions = [];
    }
  }

  void getHistoricByWorkout(WorkoutModel workout) async {
    await Provider.of<HistoricProvider>(context, listen: false)
        .getExerciseHistoricListByWorkout(workout.exercises);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        if (menuOptions.isEmpty)
          Center(
            child: Text(
              'Você não possui nenhum treino para visualizar o histórico.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
            ),
          )
        else ...[
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: DropdownButton<WorkoutModel>(
                value: workoutSelected,
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
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.grey,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                      ));
                }).toList(),
              ),
            ),
          ),
          Consumer<HistoricProvider>(
            builder: (context, historicProvider, child) {
              if (historicProvider.historicExercisesList.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum dado encontrado.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                List<ChartDataModel> chartData = historicProvider
                    .historicExercisesList[selectedExerciseIndex].chartData;

                if (chartData.isEmpty || chartData.length == 1) {
                  return const Center(
                    child: Text(
                      'Nenhum dado encontrado.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: historicProvider.historicExercisesList.length,
                  itemBuilder: (context, index) {
                    var exercise =
                        historicProvider.historicExercisesList[index];
                    return Column(
                      children: [
                        Text(
                          exercise.name,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        HistoricChart(chartData: exercise.chartData),
                      ],
                    );
                  },
                );
              }
            },
          )
        ]
      ],
    );
  }
}
