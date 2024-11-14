import 'package:flutter/material.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:gym_log/models/workout.dart';
import 'package:gym_log/pages/session/modal_finish.dart';
import 'package:gym_log/pages/session/seriescard.dart';
import 'package:gym_log/repositories/session_repository.dart';
import 'package:gym_log/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionPage extends StatefulWidget {
  final WorkoutModel workout;

  const SessionPage({Key? key, required this.workout}) : super(key: key);

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  List<Map<String, List>> exerciseWithSeries = [];
  List<ExerciseModel> exercisesToFinish = [];

  void startSession() async {
    await Provider.of<SessionRepository>(context, listen: false)
        .startSession(1);
  }

  // var exercisewithSeries  = {
  //   "Supino": [
  //     {
  //       'repetitions': 0,
  //       'weight': 0,
  //       'checked': false,
  //     }
  //   ]
  // };

  @override
  void initState() {
    super.initState();
    startSession();
    // Inicializa a lista de séries com base nos exercícios
    for (var exercise in widget.workout.exercises) {
      int countSeries = exercise.countSeries ?? 0; // Valor padrão se for nulo
      int countRepetition = exercise.countRepetition ?? 0;

      List<Map<String, dynamic>> exerciseSeries = [];
      for (int i = 0; i < countSeries; i++) {
        exerciseSeries.add({
          'repetitions': countRepetition,
          'weight': 0,
          'checked': false,
        });
      }
      exerciseWithSeries.add(
        {
          exercise.name: exerciseSeries,
        },
      );
    }
  }

  void _handleFinish() {
    for (var item in exerciseWithSeries) {
      String exerciseName = item.keys.first;
      var seriesList = item[exerciseName];

      var exercise = widget.workout.exercises
          .firstWhere((exercise) => exercise.name == exerciseName);

      // Especifica o tipo de Map para o reduce
      var maxWeightSeries = (seriesList as List<Map<String, dynamic>>?)
          ?.reduce((Map<String, dynamic> curr, Map<String, dynamic> next) {
        return curr['weight'] > next['weight'] ? curr : next;
      });

      exercisesToFinish.add(ExerciseModel(
        id: exercise.id, // ID do exercício
        name: exerciseName,
        countSeries: seriesList?.length,
        countRepetition:
            maxWeightSeries?['repetitions'], // Rep da série com maior peso
        muscleGroup: exercise.muscleGroup,
        weight: (maxWeightSeries?['weight'] as num?)?.toInt(), // Maior peso
        isCustom: exercise.isCustom, // Valor de isCustom
      ));
    }
  }

  void _addSeries(String exerciseName) {
    setState(() {
      exerciseWithSeries
          .firstWhere(
              (element) => element.containsKey(exerciseName))[exerciseName]
          ?.add({
        'repetitions': widget.workout.exercises
                .firstWhere((exercise) => exercise.name == exerciseName)
                .countRepetition ??
            0,
        'weight': 0,
        'checked': false,
      });
    });
  }

  void _removeSeries(String exerciseName, serieIndex) {
    setState(() {
      if (exerciseWithSeries
              .firstWhere(
                  (element) => element.containsKey(exerciseName))[exerciseName]!
              .length >
          1) {
        exerciseWithSeries
            .firstWhere(
                (element) => element.containsKey(exerciseName))[exerciseName]!
            .removeAt(serieIndex);
      }
    });
  }

  void _checkSeries(String exerciseName, int serieIndex) {
    setState(() {
      exerciseWithSeries.firstWhere(
              (element) => element.containsKey(exerciseName))[exerciseName]
          ?[serieIndex]['checked'] = !exerciseWithSeries.firstWhere(
              (element) => element.containsKey(exerciseName))[exerciseName]
          ?[serieIndex]['checked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return Scaffold(
        backgroundColor: const Color(0xFF1C1C21),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 36,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    widget.workout.name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_circle_right_rounded),
                    color: const Color(0xFF617AFA),
                    iconSize: 36,
                    onPressed: () {
                      _handleFinish();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: const Color(0xFF212429),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: SessionPageModal(
                              exerciseToFinish: exercisesToFinish,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: widget.workout.exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = widget.workout.exercises[index];
                    return CardSeries(
                      exercise: exercise,
                      seriesList: exerciseWithSeries,
                      onAddSeries: () => _addSeries(exercise.name),
                      onRemoveSeries: (serieIndex) =>
                          _removeSeries(exercise.name, serieIndex),
                      onCheckSeries: (serieIndex) =>
                          _checkSeries(exercise.name, serieIndex),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.sp),
              child: Button(
                label: 'FINALIZAR',
                bgColor: 0xFF617AFA,
                textColor: 0xFFFFFFFF,
                borderColor: 0xFF617AFA,
                width: 180,
                height: 20,
                onPressed: () {
                  _handleFinish();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: const Color(0xFF212429),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SessionPageModal(
                          exerciseToFinish: exercisesToFinish,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
