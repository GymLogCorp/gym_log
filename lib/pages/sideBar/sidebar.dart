import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/models/user.dart';
import 'package:gym_log/pages/addWorkout/add_workout.dart';
import 'package:gym_log/pages/historic.dart';
import 'package:gym_log/pages/home/home.dart';
import 'package:gym_log/pages/workout_list/workout_list.dart';
import 'package:gym_log/repositories/user_repository.dart';
import 'package:gym_log/services/auth_service.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text('Usuário')),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              //leading: const Icon(),
              title: const Text('Treinos'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Histórico'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
