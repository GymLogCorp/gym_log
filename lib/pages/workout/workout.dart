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
    // SimplifiedWorkoutModel(
    //   id: 1,
    //   name: 'PushDay',
    //   muscleGroup: 'Peito',
    //   exercisesCount: 6,
    // ),
    // SimplifiedWorkoutModel(
    //   id: 2,
    //   name: 'Costas e Bíceps',
    //   muscleGroup: 'Costas',
    //   exercisesCount: 6,
    // ),
    // SimplifiedWorkoutModel(
    //   id: 3,
    //   name: 'Espanca Perna',
    //   muscleGroup: 'Quadriceps',
    //   exercisesCount: 11,
    // ),
    // SimplifiedWorkoutModel(
    //   id: 4,
    //   name: 'aaaaaa',
    //   muscleGroup: 'Posterior',
    //   exercisesCount: 11,
    // ),
    // SimplifiedWorkoutModel(
    //     id: 5,
    //     name: 'mau mau homofobico',
    //     muscleGroup: 'Antebraco',
    //     exercisesCount: 4),
    // SimplifiedWorkoutModel(
    //   id: 6,
    //   name: 'Ombreta cebolão',
    //   muscleGroup: 'Ombro',
    //   exercisesCount: 4,
    // ),
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
                  return Text(
                    workout.name,
                    style: TextStyle(color: Colors.white),
                  );
                },
              )
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
}
