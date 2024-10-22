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
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 80.0.w,
          height: 10.0.h,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Séries',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 0.sp),
                    Text(
                      'Histórico',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 0.sp),
                    Text(
                      'Kg',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 0.sp),
                    Text(
                      'Repetições',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 15.sp),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: SizedBox(
                  width: 100.0.w,
                  height: 6.0.h,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side:
                            const BorderSide(color: Colors.white, width: 1.0)),
                    color: const Color(0xFF1C1C21),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 18.sp,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            '20x10',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            '22',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(width: 0.sp),
                          Text(
                            '12',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(width: 25.sp),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
