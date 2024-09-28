import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/components/input.dart';
import 'package:gym_log/pages/addWorkout/chip_list.dart';

class AddWorkout extends StatefulWidget {
  const AddWorkout({super.key});

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _workoutNameController = TextEditingController();

  String? _validateWorkoutName(String? value) {
    if (value == null || value.isEmpty) {
      return 'A nome é obrigatório';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C21),
        title: Text(
          'GymLog',
          style: GoogleFonts.plusJakartaSans(
              color: Colors.grey, fontSize: 24, fontWeight: FontWeight.normal),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              color: Color(0xFF617AFA),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        color: const Color(0xFF1C1C21),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25.0),
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
                  children: [
                    CustomTextFormField(
                      hintText: 'insira um nome para o treino',
                      title: 'Nome',
                      obscureText: false,
                      controller: _workoutNameController,
                      validator: _validateWorkoutName,
                    ),
                    const ChipList()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
