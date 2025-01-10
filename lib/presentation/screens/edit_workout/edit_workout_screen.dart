import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:gym_log/data/models/workout.dart';
import 'package:gym_log/core/widgets/input.dart';
import 'package:gym_log/presentation/components/muscle_chip_list.dart';
import 'package:gym_log/presentation/components/exercise_table.dart';
import 'package:gym_log/presentation/screens/layout/layout_screen.dart';
import 'package:gym_log/providers/workout_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditWorkout extends StatefulWidget {
  final WorkoutModel workout;
  const EditWorkout({super.key, required this.workout});

  @override
  State<EditWorkout> createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _workoutNameController = TextEditingController();
  List<ExerciseModel> exerciseList = [];
  List<String> muscleGroupList = [];
  late WorkoutProvider workoutProvider;

  String? _validateWorkoutName(String? value) {
    if (value == null || value.isEmpty) {
      return 'A nome é obrigatório';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    formatterMuscleGroup();
    workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    exerciseList = List<ExerciseModel>.from(widget.workout.exercises);
    // Configurar o nome inicial no controller
    _workoutNameController.text = widget.workout.name;
  }

  void handleAddExercise(Map<String, dynamic> exerciseData) {
    setState(() {
      exerciseList.add(ExerciseModel(
        id: exerciseData['id'],
        name: exerciseData['name'],
        series: List.generate(
          exerciseData['series'],
          (index) => SeriesModel(
            defaultRepetitions: exerciseData['repetitions'],
            lastRepetitions: 0,
            seriesIndex: index + 1,
            lastWeight: 0,
            repetitons: 0,
            weight: 0,
          ),
        ),
        muscleGroup: '',
        isCustom: exerciseData['isCustom'],
      ));
    });
  }

  void handleSubmit() async {
    var name = _workoutNameController.value.text;
    var muscleGroup = '';
    for (var muscle in muscleGroupList) {
      muscleGroup = '$muscleGroup$muscle / ';
    }
    try {
      if (_formKey.currentState!.validate() &&
          muscleGroup != '' &&
          exerciseList.isNotEmpty) {
        var dto = WorkoutModel(
          id: widget.workout.id,
          name: name,
          muscleGroup: muscleGroup,
          userId: 1,
          exercises: exerciseList,
        );
        await workoutProvider.updateWorkout(dto);
        await workoutProvider.getWorkoutList(1);
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void handleRemoveExercise(exercise) {
    exerciseList.remove(exercise);
  }

  void formatterMuscleGroup() {
    var cutMuscleGroupList = widget.workout.muscleGroup.split(" /");
    List<String> formattedList =
        cutMuscleGroupList.map((item) => item.trim()).toList();
    muscleGroupList = formattedList;
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Layout()),
                  );
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
                        limitator: 20,
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
