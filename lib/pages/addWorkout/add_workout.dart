import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddWorkout extends StatefulWidget {
  const AddWorkout({super.key});

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
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
            onPressed: () {
              print("clicou");
            },
            icon: const Icon(
              Icons.check,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        color: const Color(0xFF1C1C21),
      ),
    );
  }
}
