import 'package:flutter/material.dart';

class SessionPage extends StatelessWidget {
  final int workoutId;

  const SessionPage({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1C1C21),
      child: Center(
        child: Text(
          'Página de Sessão com ID: $workoutId',
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
