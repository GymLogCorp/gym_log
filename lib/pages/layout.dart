import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/models/user.dart';
import 'package:gym_log/pages/addWorkout/add_workout.dart';
import 'package:gym_log/pages/historic.dart';
import 'package:gym_log/pages/home/home.dart';
import 'package:gym_log/pages/sideBar/sidebar.dart';
import 'package:gym_log/pages/workout_list/workout_list.dart';
import 'package:gym_log/repositories/user_repository.dart';
import 'package:gym_log/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const Layout());

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutAppNav(); // O Scaffold e o BottomNavigationBar estão no LayoutAppNav
  }
}

class LayoutAppNav extends StatefulWidget {
  const LayoutAppNav({super.key});

  @override
  State<LayoutAppNav> createState() => _LayoutAppNavState();
}

class _LayoutAppNavState extends State<LayoutAppNav> {
  int _currentIndex = 1; // Posição inicial no BottomNavigationBar

  final wuserRepository = UserRepository();
  Future<UserModel?>? user;

  @override
  void initState() {
    super.initState();
    user = wuserRepository.getUser("teste4@email.com");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user?.then((user) {
      if (user != null) {
        print("${user.id}---------------------------------------------");
      }
      print("$user.fullName---------------------------------------------");
    });
  }

  navigateToAddWorkout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddWorkout()),
    );
  }

  final List _pages = [
    const WorkoutPage(),
    const HomePage(),
    const HistoricPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C21),
        title: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            'GymLog',
            style: GoogleFonts.plusJakartaSans(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(icon: const Icon(Icons.menu), onPressed: () {});
          },
        ),
        leadingWidth: 36,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/halter30.png'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      //const SideBar(),
      body: _pages[_currentIndex], // Renderiza a página atual
      backgroundColor: const Color(0xFF1C1C21),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        selectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF1C1C21),
        selectedItemColor: const Color(0xFF617AFA),
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Image.asset('assets/images/treinos_active.png')
                : Image.asset('assets/images/treinos.png'),
            label: 'Treinos',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Image.asset('assets/images/home_active.png')
                : Image.asset('assets/images/home.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? Image.asset('assets/images/historico_active.png')
                : Image.asset('assets/images/historico.png'),
            label: 'Histórico',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
