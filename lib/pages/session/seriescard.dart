import 'package:flutter/material.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:gym_log/widgets/button.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class CardSeries extends StatefulWidget {
  final ExerciseModel exercise;
  final List<Map<String, dynamic>> seriesList;
  final VoidCallback onAddSeries;
  final Function(int) onRemoveSeries;
  final void Function(int) onCheckSeries;

  const CardSeries({
    super.key,
    required this.exercise,
    required this.seriesList,
    required this.onAddSeries,
    required this.onRemoveSeries,
    required this.onCheckSeries,
  });

  @override
  State<CardSeries> createState() => _CardSeriesState();
}

class _CardSeriesState extends State<CardSeries> {
  @override
  Widget build(BuildContext context) {
    // Filtra as séries do exercício atual
    final exerciseSeries = widget.seriesList.firstWhere(
      (element) => element.containsKey(widget.exercise.name),
    )[widget.exercise.name] as List<Map<String, dynamic>>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.0.w,
          height: 6.0.h,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.white, width: 1.0),
            ),
            color: const Color(0xFF212429),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                  InkWell(
                    onTap: widget.onAddSeries,
                    child: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF617AFA),
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 72.0.w,
          height: 4.0.h,
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
              Text(
                'Histórico',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                'Kg',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                'Repetições',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
        // Lista de séries do exercício
        Column(
          children: List.generate(exerciseSeries.length, (index) {
            final serie = exerciseSeries[index];

            return SizedBox(
              width: 100.0.w,
              height: 5.0.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: Color(serie['checked']
                                ? 0xFF000000
                                : Colors.white.value),
                            width: 1.0),
                      ),
                      color: Color(serie['checked'] ? 0xFF617AFA : 0xFF1C1C21),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.sp,
                          vertical: 8.sp,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${index + 1}', // Índice da série
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold,
                                color: Color(serie['checked']
                                    ? 0xFF000000
                                    : Colors.white.value),
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(width: 1.sp),
                            Text(
                              widget.exercise.lastSession ?? '',
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.bold,
                                color: Color(serie['checked']
                                    ? 0xFF000000
                                    : Colors.white.value),
                                fontSize: 18.sp,
                              ),
                            ),
                            // Campo de peso
                            SizedBox(
                              width: 27.sp,
                              height: 20.sp,
                              child: TextFormField(
                                maxLength: 3,
                                decoration: InputDecoration(
                                  counterText: '',
                                ),
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  color: Color(serie['checked']
                                      ? 0xFF000000
                                      : Colors.white.value),
                                  fontSize: 18.sp,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    serie['weight'] =
                                        double.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ),
                            // Campo de repetições
                            SizedBox(
                              width: 27.sp,
                              height: 20.sp,
                              child: TextFormField(
                                maxLength: 3,
                                decoration: InputDecoration(
                                  counterText: '',
                                ),
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  color: Color(serie['checked']
                                      ? 0xFF000000
                                      : Colors.white.value),
                                  fontSize: 18.sp,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    serie['repetitions'] =
                                        int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.0.w),
                  // Checkbox para marcar série como concluída
                  InkWell(
                    onTap: () => widget.onCheckSeries(index),
                    child: Icon(
                      serie['checked']
                          ? Icons.check_circle
                          : Icons.check_circle_outline_outlined,
                      color: Color(0xFF617AFA),
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 2.0.w),
                  // Ícone de remoção de série
                  InkWell(
                    onTap: () => widget.onRemoveSeries(index),
                    child: Icon(
                      Icons.delete_forever_rounded,
                      color: index == 0 ? Colors.grey : const Color(0xFFE40928),
                      size: 32,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
