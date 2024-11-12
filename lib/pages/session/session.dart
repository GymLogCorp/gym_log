import 'package:flutter/material.dart';
import 'package:gym_log/models/workout.dart';
import 'package:gym_log/pages/session/modal_finish.dart';
import 'package:gym_log/pages/session/seriescard.dart';
import 'package:gym_log/widgets/button.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionPage extends StatefulWidget {
  final WorkoutModel workout;

  const SessionPage({Key? key, required this.workout}) : super(key: key);

  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  List<List<Map<String, dynamic>>> seriesList =
      []; // Lista de séries para cada exercício

  @override
  void initState() {
    super.initState();
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
      seriesList.add(exerciseSeries);
    }
  }

  void _addSeries(int exerciseIndex) {
    setState(() {
      seriesList[exerciseIndex].add({
        'repetitions': widget.workout.exercises[exerciseIndex].countRepetition,
        'weight': 0, // Peso inicial
        'checked': false
      });
    });
  }

  void _removeSeries(int exerciseIndex) {
    setState(() {
      if (seriesList[exerciseIndex].length > 1) {
        seriesList[exerciseIndex].removeLast();
      }
    });
  }

  void _checkSeries(int seriesIndex, int rowIndex) {
    setState(() {
      seriesList[seriesIndex][rowIndex]['checked'] =
          !seriesList[seriesIndex][rowIndex]['checked'];
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: const Color(0xFF212429),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: SessionPageModal(),
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
                      seriesList: seriesList[index],
                      onAddSeries: () => _addSeries(index),
                      onRemoveSeries: () => _removeSeries(index),
                      onCheckSeries: (rowIndex) =>
                          _checkSeries(index, rowIndex),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: const Color(0xFF212429),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SessionPageModal(),
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
