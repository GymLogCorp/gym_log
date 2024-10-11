import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget {
  final int workoutId;

  const WorkoutPage({Key? key, required this.workoutId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1C1C21),
      child: Center(
        child: Text(
          'Página do Treino com ID: $workoutId', 
          style: const TextStyle(
            
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
