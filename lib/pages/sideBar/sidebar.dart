import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

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
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                child: Text(
              'Usuário',
              style: GoogleFonts.plusJakartaSans(fontSize: 20),
            )),
            ListTile(
              leading: Image.asset('assets/images/home.png'),
              title: Text(
                'Home',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              //leading: const Icon(),
              title: Text(
                'Treinos',
                style: GoogleFonts.plusJakartaSans(),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'Histórico',
                style: GoogleFonts.plusJakartaSans(),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
