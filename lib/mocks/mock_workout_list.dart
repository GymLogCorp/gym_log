import 'package:gym_log/models/exercise.dart';
import 'package:gym_log/models/workout.dart';

final List<WorkoutModel> workoutList = [
  WorkoutModel(
      id: 1,
      name: 'PushDay',
      muscleGroup: 'Peito',
      userId: 1,
      exercises: [
        ExerciseModel(
            id: 1,
            name: 'Supino Inclinado',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Peito'),
        ExerciseModel(
            id: 2,
            name: 'Supino Reto',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Peito'),
        ExerciseModel(
            id: 3,
            name: 'Voador Peitoral',
            countSeries: 2,
            countRepetition: 12,
            muscleGroup: 'Peito'),
        ExerciseModel(
            id: 4,
            name: 'Crossover Baixo',
            countSeries: 2,
            countRepetition: 12,
            muscleGroup: 'Peito'),
        ExerciseModel(
            id: 5,
            name: 'Tríceps Pulley',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Tríceps'),
        ExerciseModel(
            id: 6,
            name: 'Tríceps Francês',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Tríceps'),
      ]),
  WorkoutModel(
      id: 2,
      name: 'Costas e Bíceps',
      muscleGroup: 'Costas',
      userId: 1,
      exercises: [
        ExerciseModel(
            id: 7,
            name: 'Puxada Aberta',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Costas'),
        ExerciseModel(
            id: 8,
            name: 'Remada na Barra',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Costas'),
        ExerciseModel(
            id: 9,
            name: 'Remada Serrote',
            countSeries: 2,
            countRepetition: 12,
            muscleGroup: 'Costas'),
        ExerciseModel(
            id: 10,
            name: 'Pulldown na Corda',
            countSeries: 2,
            countRepetition: 12,
            muscleGroup: 'Costas'),
        ExerciseModel(
            id: 11,
            name: 'Rosca Direta',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Bíceps'),
        ExerciseModel(
            id: 12,
            name: 'Rosca Martelo',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Bíceps'),
      ]),
  WorkoutModel(
      id: 3,
      name: 'Espanca Perna',
      muscleGroup: 'Quadríceps',
      userId: 1,
      exercises: [
        ExerciseModel(
            id: 13,
            name: 'Agachamento Hack',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Quadríceps'),
        ExerciseModel(
            id: 14,
            name: 'Agachamento Búlgaro',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Quadríceps'),
        ExerciseModel(
            id: 15,
            name: 'LegPress 45°',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Quadríceps'),
        ExerciseModel(
            id: 16,
            name: 'Extensora',
            countSeries: 2,
            countRepetition: 12,
            muscleGroup: 'Quadríceps'),
        ExerciseModel(
            id: 17,
            name: 'Mesa Flexora',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Posterior de coxa'),
        ExerciseModel(
            id: 18,
            name: 'Panturrilha Sentada',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Panturrilha'),
      ]),
  WorkoutModel(
      id: 4,
      name: 'Full Body A',
      muscleGroup: 'Corpo Completo',
      userId: 1,
      exercises: [
        ExerciseModel(
            id: 19,
            name: 'Levantamento Terra',
            countSeries: 3,
            countRepetition: 8,
            muscleGroup: 'Corpo Completo'),
        ExerciseModel(
            id: 20,
            name: 'Supino Reto',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Peito'),
        ExerciseModel(
            id: 21,
            name: 'Remada Curvada',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Costas'),
        ExerciseModel(
            id: 22,
            name: 'Desenvolvimento com Halteres',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Ombros'),
        ExerciseModel(
            id: 23,
            name: 'Rosca Direta',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Bíceps'),
        ExerciseModel(
            id: 24,
            name: 'Tríceps Pulley',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Tríceps'),
      ]),
  WorkoutModel(
      id: 5,
      name: 'Full Body B',
      muscleGroup: 'Corpo Completo',
      userId: 1,
      exercises: [
        ExerciseModel(
            id: 25,
            name: 'Agachamento Livre',
            countSeries: 4,
            countRepetition: 10,
            muscleGroup: 'Corpo Completo'),
        ExerciseModel(
            id: 26,
            name: 'Supino Inclinado',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Peito'),
        ExerciseModel(
            id: 27,
            name: 'Remada Sentada',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Costas'),
        ExerciseModel(
            id: 28,
            name: 'Desenvolvimento com Barra',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Ombros'),
        ExerciseModel(
            id: 29,
            name: 'Elevação Lateral',
            countSeries: 3,
            countRepetition: 12,
            muscleGroup: 'Ombros'),
        ExerciseModel(
            id: 30,
            name: 'Flexora deitada',
            countSeries: 3,
            countRepetition: 10,
            muscleGroup: 'Posterior de coxa'),
      ]),
];
