import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/models/workout.dart';

class CardWorkoutList extends StatelessWidget {
  final WorkoutModel workout;
  final bool editMode;
  final Function() onEdit;
  final Function() onDelete;

  const CardWorkoutList({
    super.key,
    required this.workout,
    required this.editMode,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 15.0, bottom: 5.0, top: 5.0),
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
          Row(
            children: [
              if (editMode) ...[
                Row(
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 20.0,
                      ),
                    ),
                    const SizedBox(width: 10.0), // Espaçamento entre os ícones
                    GestureDetector(
                      onTap: onDelete,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20.0,
                      ),
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
            ],
          ),
        ],
      ),
    );
  }
}
