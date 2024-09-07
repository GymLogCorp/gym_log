import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C21),
      body: const Center(
        child: Text(
          'Página de login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
