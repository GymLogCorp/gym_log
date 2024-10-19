import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/models/workout.dart';
import 'package:gym_log/widgets/input.dart';
import 'package:gym_log/pages/addWorkout/chip_list.dart';
import 'package:gym_log/pages/addWorkout/exercise_table.dart';
import 'package:gym_log/pages/layout.dart';
import 'package:sizer/sizer.dart';

class EditWorkout extends StatefulWidget {
  WorkoutModel workout;
  EditWorkout({super.key, required this.workout});

  @override
  State<EditWorkout> createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _workoutNameController = TextEditingController();
  String? _validateWorkoutName(String? value) {
    if (value == null || value.isEmpty) {
      return 'A nome é obrigatório';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    // Definir o valor inicial do controller
    _workoutNameController.text = widget.workout.name;
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
                        placeholder: 'insira um nome para o treino',
                        title: 'Nome',
                        obscureText: false,
                        controller: _workoutNameController,
                        validator: _validateWorkoutName,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const ChipList(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const ExerciseTableWidget()
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
