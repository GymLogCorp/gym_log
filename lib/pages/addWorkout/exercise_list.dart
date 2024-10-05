import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseListWidget extends StatefulWidget {
  const ExerciseListWidget({super.key});

  @override
  State<ExerciseListWidget> createState() => _ExerciseListWidgetState();
}

class _ExerciseListWidgetState extends State<ExerciseListWidget> {
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
                  onPressed: () => {},
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(180),
                  1: FixedColumnWidth(90),
                  2: FixedColumnWidth(90),
                },
                children: const [
                  TableRow(
                    children: [
                      Center(
                        child: Text(
                          "Título",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Séries",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Repet",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(color: Colors.white),
                    )),
                    children: [
                      Center(
                        child: Text(
                          "Supino inclinado",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          "3",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          "12",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.white),
                            bottom: BorderSide(color: Colors.white))),
                    children: [
                      Center(
                        child: Text(
                          "Voador peitoral",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          "3",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Text(
                          "12",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }
}
