import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1C1C21),
      body: Center(
        child: Text(
          'Página de login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
