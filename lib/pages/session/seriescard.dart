import 'package:flutter/material.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class CardSeries extends StatefulWidget {
  ExerciseModel exercise;
  CardSeries({super.key, required this.exercise});

  @override
  State<CardSeries> createState() => _CardSeriesState();
}

class _CardSeriesState extends State<CardSeries> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5.0),
        SizedBox(
          width: 100.0.w,
          height: 6.0.h,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.white, width: 1.0)),
            color: const Color(0xFF212429),
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.exercise.name,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF617AFA),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
