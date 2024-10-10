import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/components/button.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class SimplifiedWorkoutModel {
  final int id;
  final String name;
  final String muscleGroup;
  final int exercisesCount;

  SimplifiedWorkoutModel(
      {required this.id,
      required this.name,
      required this.muscleGroup,
      required this.exercisesCount});
}

class _WorkoutPageState extends State<WorkoutPage> {
  final List<SimplifiedWorkoutModel> simplifiedWorkoutList = [
    SimplifiedWorkoutModel(
      id: 1,
      name: 'PushDay',
      muscleGroup: 'Peito',
      exercisesCount: 6,
    ),
    SimplifiedWorkoutModel(
      id: 2,
      name: 'Costas e Bíceps',
      muscleGroup: 'Costas',
      exercisesCount: 6,
    ),
    SimplifiedWorkoutModel(
      id: 3,
      name: 'Espanca Perna',
      muscleGroup: 'Quadriceps',
      exercisesCount: 11,
    ),
    SimplifiedWorkoutModel(
      id: 4,
      name: 'aaaaaa',
      muscleGroup: 'Posterior',
      exercisesCount: 11,
    ),
    SimplifiedWorkoutModel(
        id: 5,
        name: 'mau mau homofobico',
        muscleGroup: 'Antebraco',
        exercisesCount: 4),
    SimplifiedWorkoutModel(
      id: 6,
      name: 'Ombreta cebolão',
      muscleGroup: 'Ombro',
      exercisesCount: 4,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Meus treinos:',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60.0,
        ),
        simplifiedWorkoutList.isEmpty
            ? containerNotWorkout()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: simplifiedWorkoutList.length,
                itemBuilder: (context, index) {
                  final workout = simplifiedWorkoutList[index];
                  return cardWorkout(workout);
                },
              ),
        Button(
          onPressedProps: () {},
          label: 'Adicionar  Treino',
          bgColor: 0xFF617AFA,
          textColor: 0xFFFFFFFF,
          borderColor: 0xFF617AFA,
        ),
      ],
    );
  }

  Widget containerNotWorkout() {
    return Column(
      children: [
        Text(
          'Você ainda não possui \n treinos, crie para gerenciar ',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 80.0,
        ),
        Button(
          onPressedProps: () {},
          label: 'Criar',
          bgColor: 0xFF617AFA,
          textColor: 0xFFFFFFFF,
          borderColor: 0xFF617AFA,
        )
      ],
    );
  }

  Widget cardWorkout(SimplifiedWorkoutModel workout) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(8), // Espaçamento interno para o ícone
                decoration: BoxDecoration(
                  color: Color(0xFFE40928), // Cor de fundo da moldura
                  borderRadius: BorderRadius.circular(7), // Bordas arredondadas
                ),
                child: Icon(
                  Icons.fitness_center, // Ícone
                  color: Colors.white, // Cor do ícone
                  size: 20, // Tamanho do ícone
                ),
              ),
              SizedBox(width: 8.0),
              // Coluna com título e subtítulo
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinha à esquerda
                children: [
                  Container(
                    child: Text(
                      workout.name,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 1), // Espaçamento entre título e subtítulo
                  Text(
                    workout.muscleGroup,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            workout.exercisesCount.toString(), // Numeração
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
