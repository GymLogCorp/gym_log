import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:gym_log/models/workout.dart';
import 'package:gym_log/repositories/workout_repository.dart';
import 'package:gym_log/widgets/input.dart';
import 'package:gym_log/pages/addWorkout/chip_list.dart';
import 'package:gym_log/pages/addWorkout/exercise_table.dart';
import 'package:gym_log/pages/layout.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddWorkout extends StatefulWidget {
  const AddWorkout({super.key});

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _workoutNameController = TextEditingController();
  final List<ExerciseModel> exerciseList = [];
  final List<String> muscleGroupList = [];
  String? _validateWorkoutName(String? value) {
    if (value == null || value.isEmpty) {
      return 'A nome é obrigatório';
    }
    return null;
  }

  void handleAddExercise(Map<String, dynamic> exerciseData) {
    setState(() {
      exerciseList.add(ExerciseModel(
        id: exerciseData['id'],
        name: exerciseData['name'],
        countSeries: exerciseData['series'],
        countRepetition: exerciseData['repetitions'],
        muscleGroup: '',
        isCustom: false,
      ));
    });
  }

  void handleRemoveExercise(exercise) {
    exerciseList.remove(exercise);
  }

  void handleSubmit() async {
    var name = _workoutNameController.value.text;
    var muscleGroup = '';
    for (var muscle in muscleGroupList) {
      muscleGroup = muscleGroup + '$muscle / ';
    }
    try {
      if (_formKey.currentState!.validate() &&
          muscleGroup != '' &&
          exerciseList.isNotEmpty) {
        var dto = WorkoutModel(
          name: name,
          muscleGroup: muscleGroup,
          userId: 1,
          exercises: exerciseList,
        );
        await Provider.of<WorkoutRepository>(context, listen: false)
            .createWorkout(dto);
        await Provider.of<WorkoutRepository>(context, listen: false)
            .getWorkoutList(1);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF1C1C21),
            title: Text(
              'GymLog',
              style: GoogleFonts.plusJakartaSans(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.normal),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  handleSubmit();
                },
                icon: const Icon(
                  Icons.check,
                  color: Color(0xFF617AFA),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: Container(
            width: 100.0.w,
            height: 100.0.h,
            color: const Color(0xFF1C1C21),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                  child: Text(
                    'Novo treino',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        placeholder: 'insira um nome para o treino',
                        title: 'Nome',
                        obscureText: false,
                        controller: _workoutNameController,
                        validator: _validateWorkoutName,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ChipList(
                        filter: muscleGroupList,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ExerciseTableWidget(
                        onExerciseAdded: handleAddExercise,
                        onExerciseRemoved: handleRemoveExercise,
                        exerciseList: exerciseList,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
