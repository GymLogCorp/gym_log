import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/components/button.dart';
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
    )
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
          child: simplifiedWorkoutList.isEmpty
              ? containerNotWorkout()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: simplifiedWorkoutList.length,
                  itemBuilder: (context, index) {
                    final workout = simplifiedWorkoutList[index];
                    return InkWell(
                      onTap: () {
                        if (!editMode) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color(0xFF1E1E1E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0),
                                ),
                                title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Exercícios',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Séries',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                          height:
                                              8), // Espaço entre o texto e a linha
                                      const Divider(
                                        color: Colors.white, // Cor da linha
                                        thickness: 1.0, // Espessura da linha
                                      ),
                                    ]),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Grupo Muscular: ${workout.muscleGroup}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Quantidade de Exercícios: ${workout.exercisesCount}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            60.0), // Espaço entre o texto e a linha
                                    const Divider(
                                      color:
                                          Colors.red, // Cor da linha divisória
                                      thickness: 4.0, // Espessura da linha
                                    ),
                                  ],
                                ),
                                actions: [
                                  Center(
                                    child: SizedBox(
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
                                  ),
                                ],
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
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _editWorkout(workout);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _deleteWorkout(workout.id);
                    },
                  ),
                ],
              ),
            ] else
              Text(
                workout.exercisesCount.toString(),
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
      simplifiedWorkoutList.removeWhere((workout) => workout.id == workoutId);
    });
  }

  void _editWorkout(SimplifiedWorkoutModel workout) {
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
  final SimplifiedWorkoutModel workout;

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
