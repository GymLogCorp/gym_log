import 'package:flutter/material.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:gym_log/data/models/session.dart';
import 'package:gym_log/data/models/workout.dart';
import 'package:gym_log/presentation/screens/session/widgets/modal_finish.dart';
import 'package:gym_log/presentation/screens/session/widgets/series_card.dart';
import 'package:gym_log/providers/session_provider.dart';
import 'package:gym_log/core/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionPage extends StatefulWidget {
  final WorkoutModel workout;

  const SessionPage({super.key, required this.workout});

  @override
  // ignore: library_private_types_in_public_api
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  List<ExerciseModel> exercisesToFinish = [];

  void startSession() async {
    await Provider.of<SessionProvider>(context, listen: false).startSession(1);
  }

  @override
  void initState() {
    super.initState();
    startSession();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SessionProvider>(context, listen: false)
          .setDefaultWorkout(widget.workout);
    });
  }

  void _handleFinish() {
    final exerciseWithSeries =
        Provider.of<SessionProvider>(context, listen: false).exerciseWithSeries;
    for (var exerciseSeries in exerciseWithSeries) {
      String exerciseName = exerciseSeries.name;
      var seriesList = exerciseSeries.series;

      var exercise = widget.workout.exercises
          .firstWhere((exercise) => exercise.name == exerciseName);

      // Especifica o tipo de Map para o reduce
      var maxWeightSeries =
          seriesList.reduce((SeriesModel curr, SeriesModel next) {
        return curr.weight > next.weight ? curr : next;
      });

      exercisesToFinish.add(ExerciseModel(
        id: exercise.id,
        name: exerciseName,
        countSeries: seriesList.length,
        countRepetition:
            maxWeightSeries.repetitions, // Rep da série com maior peso
        muscleGroup: exercise.muscleGroup,
        weight: maxWeightSeries.weight.toInt(), // Maior peso
        isCustom: exercise.isCustom, // Valor de isCustom
      ));
    }
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
                  // IconButton(
                  //   icon: const Icon(Icons.arrow_back),
                  //   color: Colors.white,
                  //   iconSize: 36,
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                  Image.asset('assets/images/halter30.png'),
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
                child: Consumer<SessionProvider>(
                  builder: (context, sessionState, child) {
                    return ListView.builder(
                      itemCount: sessionState.exerciseWithSeries.length,
                      itemBuilder: (context, index) {
                        final exercise = sessionState.exerciseWithSeries[index];
                        return CardSeries(
                          key: ValueKey(exercise.name),
                          exercise: exercise,
                        );
                      },
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
                height: 58,
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
