import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/components/button.dart';
import 'package:gym_log/pages/home/not_workout_card.dart';
import 'package:gym_log/pages/home/workout_card.dart';
import 'package:gym_log/pages/session/session.dart';
import 'package:gym_log/pages/session/session.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class ExerciseModel {
  final int id;
  final String name;
  final int countSeries;
  final int countRepetition;
  final double? weight;
  final int workoutId;
  ExerciseModel({
    required this.id,
    required this.name,
    required this.countSeries,
    required this.countRepetition,
    this.weight,
    required this.workoutId,
  });
}

class WorkoutModel {
  final int id;
  final String name;
  final String muscleGroup;
  final int userId;
  final List<ExerciseModel> exercises;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.userId,
    required this.exercises,
  });
  String getSeriesRepsString() {
    return exercises
        .map(
            (exercise) => '${exercise.countSeries}x${exercise.countRepetition}')
        .join(', ');
  }
}

class _HomePageState extends State<HomePage> {
  final List<WorkoutModel> workoutList = [
    WorkoutModel(
        id: 1,
        name: 'PushDay',
        muscleGroup: 'Peito',
        userId: 1,
        exercises: [
          ExerciseModel(
              id: 1,
              name: 'Supino Inclinado',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 1),
          ExerciseModel(
              id: 2,
              name: 'Supino reto',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 1),
          ExerciseModel(
              id: 3,
              name: 'Voador Peitoral',
              countSeries: 2,
              countRepetition: 12,
              weight: null,
              workoutId: 1),
          ExerciseModel(
              id: 4,
              name: 'Crossover Baixo',
              countSeries: 2,
              countRepetition: 12,
              weight: null,
              workoutId: 1),
          ExerciseModel(
              id: 5,
              name: 'Tríceps Pulley',
              countSeries: 3,
              countRepetition: 10,
              weight: null,
              workoutId: 1),
          ExerciseModel(
              id: 6,
              name: 'Tríceps Francês',
              countSeries: 3,
              countRepetition: 10,
              weight: null,
              workoutId: 1),
        ]),
    WorkoutModel(
        id: 2,
        name: 'Costas e Bíceps',
        muscleGroup: 'Costas',
        userId: 1,
        exercises: [
          ExerciseModel(
              id: 7,
              name: 'Puxada Aberta',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 2),
          ExerciseModel(
              id: 8,
              name: 'Remada na Barra',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 2),
          ExerciseModel(
              id: 9,
              name: 'Remada Serrote',
              countSeries: 2,
              countRepetition: 12,
              weight: null,
              workoutId: 2),
          ExerciseModel(
              id: 10,
              name: 'Pulldown na Corda',
              countSeries: 2,
              countRepetition: 12,
              weight: null,
              workoutId: 2),
          ExerciseModel(
              id: 11,
              name: 'Rosca Direta',
              countSeries: 3,
              countRepetition: 10,
              weight: null,
              workoutId: 2),
          ExerciseModel(
              id: 12,
              name: 'Rosca Martelo',
              countSeries: 3,
              countRepetition: 10,
              weight: null,
              workoutId: 2),
        ]),
    WorkoutModel(
        id: 3,
        name: 'Espanca Perna',
        muscleGroup: 'Quadriceps',
        userId: 1,
        exercises: [
          ExerciseModel(
              id: 13,
              name: 'Agachamento Hack',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 13,
              name: 'Agachamento Hack',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 13,
              name: 'Agachamento Hack',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 13,
              name: 'Agachamento Búlgaro',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 13,
              name: 'Agachamento Hack',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 13,
              name: 'cccccccccccccccccccccccccccccc',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 14,
              name: 'LegPress 45°',
              countSeries: 3,
              countRepetition: 12,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 15,
              name: 'Extensora',
              countSeries: 2,
              countRepetition: 12,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 16,
              name: 'Flexora',
              countSeries: 2,
              countRepetition: 12,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 17,
              name: 'Mesa Flexora',
              countSeries: 3,
              countRepetition: 10,
              weight: null,
              workoutId: 3),
          ExerciseModel(
              id: 18,
              name: 'Panturrilha Sentada',
              countSeries: 3,
              countRepetition: 10,
              weight: null,
              workoutId: 3),
        ]),
  ];
  int _currentWorkoutId = 1;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return Scaffold(
        backgroundColor: const Color(0xFF1C1C21),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                workoutList.isEmpty
                    ? const NotWorkoutCard()
                    : CarouselSlider(
                        items: workoutList
                            .map((workout) => WorkoutCard(workout: workout))
                            .toList(),
                        options: CarouselOptions(
                          height: 85.h,
                          viewportFraction: 0.8,
                          enableInfiniteScroll: true,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentWorkoutId = workoutList[index].id;
                            });
                          },
                        ),
                      ),
                Button(
                  label: 'COMEÇAR',
                  bgColor: workoutList.isEmpty ? 0xFF38383D : 0xFF617AFA,
                  textColor: 0xFFFFFFFF,
                  borderColor: workoutList.isEmpty ? 0xFF38383D : 0xFF617AFA,
                  width: 250,
                  height: 68,
                  icon: Icons.play_arrow_rounded,
                  iconSize: 30.0.sp,
                  onPressed: () {
                    final selectedWorkout = workoutList.firstWhere(
                      (workout) => workout.id == _currentWorkoutId,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SessionPage(workout: selectedWorkout),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
