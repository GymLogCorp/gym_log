// empty_training_section.dart
import 'package:flutter/material.dart';
import 'package:gym_log/pages/workout_list/workout_list.dart';
import 'package:gym_log/widgets/button.dart';
import 'package:sizer/sizer.dart';
import 'package:gym_log/pages/addWorkout/add_workout.dart';

class NotWorkoutCard extends StatelessWidget {
  const NotWorkoutCard({super.key});

  void navigateToWorkout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddWorkout(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70.0.h,
          width: 80.0.w,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
                side: const BorderSide(color: Color(0xFF464A56), width: 3.0)),
            color: const Color(0xFF212429),
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Crie novos treinos para\n começar a gerenciar',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                      const SizedBox(height: 25.0),
                      Image.asset(
                        'assets/images/clipboard_central.png',
                      ),
                      const SizedBox(height: 25.0),
                      Button(
                        label: 'CRIAR',
                        bgColor: (0xFF617AFA),
                        textColor: 0xFFFFFFFF,
                        borderColor: (0xFF617AFA),
                        width: 150,
                        height: 55,
                        icon: Icons.add,
                        iconSize: 30.0,
                        onPressed: () {
                          navigateToWorkout(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
