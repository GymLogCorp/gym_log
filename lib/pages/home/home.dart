import 'package:flutter/material.dart';
import 'package:gym_log/pages/session/session.dart';
import 'package:gym_log/widgets/button.dart';
import 'package:gym_log/pages/home/not_workout_card.dart';
import 'package:gym_log/pages/home/card_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:gym_log/repositories/workout_repository.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _currentWorkoutId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WorkoutRepository>(context, listen: false).getWorkoutList(1);
  }

  @override
  Widget build(BuildContext context) {
    final workoutList = Provider.of<WorkoutRepository>(context).workoutList;
    return Sizer(builder: (context, orientation, screenType) {
      return Scaffold(
        backgroundColor: const Color(0xFF1C1C21),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                workoutList.isEmpty
                    ? const NotWorkoutCard()
                    : CarouselSlider(
                        items: workoutList
                            .map((workout) => CardCarousel(workout: workout))
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
                      ),
                Button(
                  label: 'COMEÇAR',
                  bgColor: workoutList.isEmpty ? 0xFF38383D : 0xFF617AFA,
                  textColor: 0xFFFFFFFF,
                  borderColor: workoutList.isEmpty ? 0xFF38383D : 0xFF617AFA,
                  width: 250,
                  height: 68,
                  icon: Icons.play_arrow_rounded,
                  iconSize: 30.0.sp,
                  onPressed: () {
                    final selectedWorkout = workoutList.firstWhere(
                      (workout) => workout.id == _currentWorkoutId,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SessionPage(workout: selectedWorkout),
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
