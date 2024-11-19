import 'package:flutter/material.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:gym_log/pages/layout.dart';
import 'package:gym_log/widgets/button.dart';

class SummaryPage extends StatelessWidget {
  final List<ExerciseModel> exercises;

  const SummaryPage({Key? key, required this.exercises}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C21),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 10.sp),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Text(
              "Treino Finalizado:",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3.h),
            // Card para o resumo do treino
            SizedBox(
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
                      // Título para os Exercícios e Séries
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
                      // Lista de Exercícios
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = exercises[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20.0, left: 6.0),
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
                                // Condicional para mostrar o Peso Máximo, se existir
                                if (exercise.weight != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, right: 20.0, top: 5.0),
                                    child: Text(
                                      "Peso Máximo: ${exercise.weight} kg",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14.sp,
                                        color: Colors.white70,
                                      ),
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
                        color: Color(0xFF617AFA),
                        thickness: 4.0,
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      // Botão para voltar
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.sp),
                        child: Button(
                          label: 'VOLTAR',
                          bgColor: 0xFF617AFA,
                          textColor: 0xFFFFFFFF,
                          borderColor: 0xFF617AFA,
                          width: 140,
                          height: 20,
                          onPressed: () {
                            // Navega para a Home (ou página inicial)
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Layout(), // Altere para sua página inicial
                              ),
                              (route) =>
                                  false, // Remove todas as rotas anteriores
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
