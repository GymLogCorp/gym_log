import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/data/models/workout.dart';
import 'package:sizer/sizer.dart';

class CardCarousel extends StatefulWidget {
  final WorkoutModel workout;

  const CardCarousel({super.key, required this.workout});

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.workout.name,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
        ),
        const SizedBox(height: 5.0),
        SizedBox(
          width: 80.0.w,
          height: 70.0.h,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: const BorderSide(color: Color(0xFF464A56), width: 3.0)),
            color: const Color(0xFF212429),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding: const EdgeInsets.only(left: 30.0),
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
                  SizedBox(
                    height: 50.0.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.workout.exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = widget.workout.exercises[index];
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
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
