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
          child: Container(
            child: Image.asset('./assets/images/logo_branca_sem_fundo.png'),
          ),
        ),
      ),
    );
  }
}
