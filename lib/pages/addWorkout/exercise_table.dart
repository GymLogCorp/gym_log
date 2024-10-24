import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:gym_log/pages/addWorkout/addExercise/add_exercise.dart';
import 'package:sizer/sizer.dart';

class ExerciseTableWidget extends StatefulWidget {
  const ExerciseTableWidget({super.key});

  @override
  State<ExerciseTableWidget> createState() => _ExerciseTableWidgetState();
}

class _ExerciseTableWidgetState extends State<ExerciseTableWidget> {
  final List<ExerciseModel> exerciseList = [
    ExerciseModel(
        id: 1,
        name: 'Supino Inclinado na Máquina',
        countSeries: 4,
        countRepetition: 10,
        muscleGroup: ''),
    ExerciseModel(
        id: 2,
        name: 'Supino Reto c/ Halteres',
        countSeries: 3,
        countRepetition: 10,
        muscleGroup: ''),
    ExerciseModel(
        id: 3,
        name: 'Voador',
        countSeries: 3,
        countRepetition: 12,
        muscleGroup: ''),
    ExerciseModel(
        id: 4,
        name: 'Tríceps c/ Corda',
        countSeries: 3,
        countRepetition: 12,
        muscleGroup: ''),
    ExerciseModel(
        id: 5,
        name: 'Tríceps Frânces na Polia',
        countSeries: 3,
        countRepetition: 12,
        muscleGroup: '')
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Exercícios ',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: 24,
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => const Dialog(
                            child: AddExerciseModal(),
                          )),
                  icon: const Icon(
                    Icons.add_circle,
                    color: Color(0xFF617AFA),
                    size: 24,
                  ),
                  padding:
                      EdgeInsets.zero, // Remove padding interno do IconButton
                  constraints:
                      const BoxConstraints(), // Remove as restrições padrão do IconButton
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Card(
          color: const Color(0xFF212429),
          child: Table(
            border: TableBorder.all(
                color: const Color(0xFF464A56),
                borderRadius: BorderRadius.circular(20.0),
                width: 2.0,
                style: BorderStyle.solid),
            columnWidths: <int, TableColumnWidth>{
              0: FixedColumnWidth(40.0.w),
              1: FixedColumnWidth(23.0.w),
              2: FixedColumnWidth(18.0.w),
              3: FixedColumnWidth(10.0.w)
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Nome",
                        softWrap: true,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Séries",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Rep",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox()
                ],
              ),
              ...exerciseList.map(
                (exercise) => TableRow(
                  // decoration: const BoxDecoration(
                  //     border: Border(
                  //   top: BorderSide(color: Colors.white),
                  // )),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          exercise.name,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        heightFactor: 2.5,
                        child: Text(
                          exercise.countSeries.toString(),
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          exercise.countRepetition.toString(),
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
