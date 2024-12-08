import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/utils/mocks/mock_workout_list.dart';
import 'package:gym_log/data/models/workout.dart';
import 'package:gym_log/ui/edit_workout/widgets/edit_workout_screen.dart';
import 'package:gym_log/ui/workout/widgets/workout_list_card.dart';
import 'package:gym_log/ui/workout/widgets/workout_detail_card.dart';
import 'package:gym_log/data/repositories/workout_repository.dart';
import 'package:gym_log/ui/core/widgets/button.dart';
import 'package:gym_log/ui/add_workout/widgets/add_workout_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  bool editMode =
      false; // Controla se os botões de editar/excluir estão visíveis

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WorkoutRepository>(context, listen: false).getWorkoutList(1);
  }

  void handleRemove(int id) async {
    try {
      await Provider.of<WorkoutRepository>(context, listen: false)
          .deleteWorkoutById(id);
      await Provider.of<WorkoutRepository>(context, listen: false)
          .getWorkoutList(1);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return Column(
        mainAxisSize: MainAxisSize.min,
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
                  size: 30.0,
                ),
                onPressed: () {
                  setState(() {
                    editMode = !editMode;
                  });
                },
              )
            ],
          ),
          SizedBox(
            height: 7.0.h,
          ),
          Expanded(child: Consumer<WorkoutRepository>(
              builder: (context, workoutRepository, child) {
            List<WorkoutModel> workouts = workoutRepository.workoutList;
            print(workouts);
            return workouts.isEmpty
                ? containerNotWorkout()
                : ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      return InkWell(
                        onTap: () {
                          if (!editMode) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: const Color(0xFF212429),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  child:
                                      WorkoutDetailComponent(workout: workout),
                                );
                              },
                            );
                          }
                        },
                        child: CardWorkoutList(
                          workout: workout,
                          editMode: editMode,
                          onDelete: () => {handleRemove(workout.id!)},
                          onEdit: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditWorkout(
                                        workout: workout,
                                      )),
                            )
                          },
                        ),
                      );
                    },
                  );
          })),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Button(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddWorkout()),
                );
              },
              label: 'Adicionar Treino',
              width: 250,
              height: 68,
              bgColor: 0xFF617AFA,
              textColor: 0xFFFFFFFF,
              borderColor: 0xFF617AFA,
            ),
          ),
        ],
      );
    });
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
}
