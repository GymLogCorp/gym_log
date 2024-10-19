import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/components/button.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:gym_log/models/workout.dart';
import 'package:gym_log/pages/addWorkout/add_workout.dart';

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

  bool editMode =
      false; // Controla se os botões de editar/excluir estão visíveis

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Meus treinos:',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                editMode ? Icons.check : Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  editMode = !editMode;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 25.0,
        ),
        SizedBox(
          height: 480.0,
          child: workoutList.isEmpty
              ? containerNotWorkout()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: workoutList.length,
                  itemBuilder: (context, index) {
                    final workout = workoutList[index];
                    return InkWell(
                      onTap: () {
                        if (!editMode) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Color(0xFF1E1E1E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                ),
                                child: SizedBox(
                                  height: 500.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Exercícios',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Séries',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                        thickness: 1.0,
                                      ),

                                      SizedBox(
                                        height:
                                            250.0, // Definindo a altura máxima da lista
                                        child: ListView.builder(
                                          itemCount: workout.exercises.length,
                                          itemBuilder: (context, index) {
                                            final exercise =
                                                workout.exercises[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      exercise.name,
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    Text(
                                                      '${exercise.countSeries}x${exercise.countRepetition}',
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ]),
                                            );
                                          },
                                        ),
                                      ),

                                      const SizedBox(
                                          height:
                                              10.0), // Espaço entre o texto e a linha
                                      const Divider(
                                        color: Colors.red,
                                        thickness: 4.0,
                                      ),
                                      SizedBox(
                                        width: 100.0,
                                        height: 50.0,
                                        child: Button(
                                          onPressed: () {},
                                          icon: Icons.play_arrow_rounded,
                                          iconSize: 40.0,
                                          bgColor: 0xFFE40928,
                                          borderColor: 0xFFE40928,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: cardWorkout(workout),
                    );
                  },
                ),
        ),
        const SizedBox(height: 70.0),
        Button(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddWorkout()),
            );
          },
          label: 'Adicionar Treino',
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
      ],
    );
  }

  Widget cardWorkout(WorkoutModel workout) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE40928),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.name,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    workout.muscleGroup,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(children: [
            if (editMode) ...[
              Row(
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.edit, color: Colors.blue, size: 20.0),
                    onPressed: () {
                      _editWorkout(workout);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20.0,
                    ),
                    onPressed: () {
                      _deleteWorkout(workout.id);
                    },
                  ),
                ],
              ),
            ] else
              Text(
                workout.exercises.length.toString(),
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
          ]),
        ],
      ),
    );
  }

  void _deleteWorkout(int workoutId) {
    setState(() {
      workoutList.removeWhere((workout) => workout.id == workoutId);
    });
  }

  void _editWorkout(WorkoutModel workout) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditWorkoutPage(
          workout: workout,
        ),
      ),
    );
  }
}

class WorkoutDetailPage extends StatelessWidget {
  final SimplifiedWorkoutModel workout;

  const WorkoutDetailPage({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Treino: ${workout.name}'),
            Text('Grupo Muscular: ${workout.muscleGroup}'),
            Text('Quantidade de Exercícios: ${workout.exercisesCount}'),
          ],
        ),
      ),
    );
  }
}

class EditWorkoutPage extends StatelessWidget {
  final WorkoutModel workout;

  const EditWorkoutPage({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar ${workout.name}'),
      ),
      body: Center(
        child: Text('Aqui você pode editar o treino ${workout.name}'),
      ),
    );
  }
}
