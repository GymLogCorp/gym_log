import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/components/button.dart';
import 'package:gym_log/pages/workout.dart';
//import 'package:gym_log/pages/home/carousel.dart';
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

  void navigateToWorkout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WorkoutPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return Scaffold(
        backgroundColor: const Color(0xFF1C1C21),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                workoutList.isEmpty
                    ? _buildEmptyTrainingSection()
                    : CarouselSlider(
                        items: workoutList
                            .map((workout) => _buildWorkoutCard(workout))
                            .toList(),
                        options: CarouselOptions(
                          height: 85.h,
                          viewportFraction: 0.7,
                          enableInfiniteScroll: true,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.4,
                        ),
                      ),
                Button(
                  label: 'COMEÇAR',
                  bgColor: workoutList.isEmpty ? (0xFF212429) : (0xFF617AFA),
                  textColor: 0xFFFFFFFF,
                  borderColor: workoutList.isEmpty ? 0xFF4F5461 : (0xFF617AFA),
                  width: 268,
                  height: 68,
                  icon: Icons.play_arrow_rounded,
                  iconSize: 30.0.sp,
                  onPressed: () {
                    navigateToWorkout(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  _buildEmptyTrainingSection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(5.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF1E1E2F), // Cor de fundo do card
              borderRadius: BorderRadius.circular(15), // Bordas arredondadas
              border: Border.all(
                color: Colors.white, // Cor da borda
                width: 2.0, // Largura da borda
              ),
            ),
            padding: EdgeInsets.all(16.0), // Espaçamento interno
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Crie novos treinos para começar a gerenciar',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h), // Espaço entre o texto e a imagem
                Image.asset(
                  'assets/images/treinos.png',
                  alignment: Alignment.center,
                ),
                SizedBox(height: 10.h), // Espaço entre a imagem e o botão
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: Button(
                    label: 'Criar ',
                    bgColor: 0xFF617AFA,
                    textColor: 0xFFFFFFFF,
                    borderColor: 0xFF617AFA,
                    width: 70.w,
                    height: 5.h,
                    icon: Icons.add,
                    iconSize: 35.sp,
                    onPressed: () => navigateToWorkout(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(WorkoutModel workout) {
    return Column(
      children: [
        Text(
          workout.name,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
        ),
        const SizedBox(height: 5.0),
        Card(
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
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Séries',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                  height: 290.0, // Ajuste a altura conforme necessário
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: workout.exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = workout.exercises[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  exercise.name,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                '${workout.getSeriesRepsString().split(',')[index]}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
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
      ],
    );
  }
}
