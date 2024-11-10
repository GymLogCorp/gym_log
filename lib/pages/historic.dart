import 'package:flutter/material.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:gym_log/repositories/exercise_repository.dart';
import 'package:provider/provider.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  List<ExerciseModel> exercises = [];
  String exerciseTyped = 'Agacha';
  void getExercises() async {
    var response = await Provider.of<ExerciseRepository>(context, listen: false)
        .searchExerciseListByName(exerciseTyped);
    exercises = response;
  }

  @override
  void initState() {
    super.initState();
    getExercises();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1C1C21),
      child: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          ExerciseModel item = exercises[index];
          return Column(
            children: [
              Text(
                item.name,
                style: const TextStyle(color: Colors.white),
              )
            ],
          );
        },
      ),
    );
  }
}
