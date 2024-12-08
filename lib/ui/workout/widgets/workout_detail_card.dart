// workout_detail_component.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/data/models/workout.dart';
import 'package:gym_log/ui/session/widgets/session_screen.dart';
import 'package:gym_log/ui/core/widgets/button.dart';
import 'package:sizer/sizer.dart';

class WorkoutDetailComponent extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutDetailComponent({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0.w,
      height: 70.0.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: const Color(0xFF212429),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Exercícios',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(
                      'Séries',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.white,
                thickness: 2.0,
              ),
              const SizedBox(height: 5.0),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: workout.exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = workout.exercises[index];
                    return Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 6.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  exercise.name,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                '${exercise.countSeries}x${exercise.countRepetition}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              const Divider(
                color: Colors.red,
                thickness: 4.0,
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Button(
                width: 100.0,
                height: 50.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SessionPage(
                              workout: workout,
                            )),
                  );
                },
                icon: Icons.play_arrow_rounded,
                iconSize: 40.0,
                bgColor: 0xFFE40928,
                borderColor: 0xFFE40928,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
