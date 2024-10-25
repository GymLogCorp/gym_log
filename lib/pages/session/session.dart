import 'package:flutter/material.dart';
import 'package:gym_log/models/workout.dart';
import 'package:gym_log/pages/session/modal_finish.dart';
import 'package:gym_log/pages/session/seriescard.dart';
import 'package:gym_log/widgets/button.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionPage extends StatelessWidget {
  final WorkoutModel workout;

  const SessionPage({Key? key, required this.workout}) : super(key: key);

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
                    workout.name,
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
                      // navigateTo (overlay/modal de finalizar o treino)
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: workout.exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = workout.exercises[index];
                      return CardSeries(exercise: exercise);
                    },
                  )),
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
