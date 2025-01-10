import 'package:flutter/material.dart';
import 'package:gym_log/presentation/screens/session/session_screen.dart';
import 'package:gym_log/core/widgets/button.dart';
import 'package:gym_log/presentation/screens/home/widgets/not_workout_card.dart';
import 'package:gym_log/presentation/screens/home/widgets/carrosel_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gym_log/providers/workout_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _currentWorkoutId;

  late WorkoutProvider workoutProvider;

  @override
  void initState() {
    super.initState();
    workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    workoutProvider.getWorkoutList(1).then((_) {
      if (workoutProvider.workoutList.isNotEmpty) {
        setState(() {
          print("CHEGOU AQUI ------------------");
          _currentWorkoutId = workoutProvider.workoutList.first.id;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return Scaffold(
        backgroundColor: const Color(0xFF1C1C21),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<WorkoutProvider>(
                  builder: (context, workoutRepository, child) {
                    final workoutList = workoutRepository.workoutList;
                    return workoutList.isEmpty
                        ? const NotWorkoutCard()
                        : CarouselSlider(
                            items: workoutList
                                .map(
                                    (workout) => CardCarousel(workout: workout))
                                .toList(),
                            options: CarouselOptions(
                              height: 85.h,
                              viewportFraction: 0.8,
                              enableInfiniteScroll: true,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentWorkoutId = workoutList[index].id!;
                                });
                              },
                            ),
                          );
                  },
                ),
                Consumer<WorkoutProvider>(
                  builder: (context, workoutRepository, child) {
                    final workoutList = workoutRepository.workoutList;

                    return Visibility(
                      visible: workoutList.isNotEmpty,
                      child: Button(
                        label: 'COMEÇAR',
                        bgColor: 0xFF617AFA,
                        textColor: 0xFFFFFFFF,
                        borderColor: 0xFF617AFA,
                        width: 250,
                        height: 68,
                        icon: Icons.play_arrow_rounded,
                        iconSize: 30.0.sp,
                        onPressed: workoutList.isEmpty
                            ? null
                            : () {
                                final selectedWorkout = workoutList.firstWhere(
                                  (workout) => workout.id == _currentWorkoutId,
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SessionPage(workout: selectedWorkout),
                                  ),
                                );
                              },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
