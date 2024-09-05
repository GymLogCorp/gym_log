import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GymLog',
      home: Scaffold(
        backgroundColor: const Color(0xFF1C1C21),
        body: Center(
          child: Image.asset('./images/logo_sem_fundo.png'),
        ),
      ),
    );
  }
}
