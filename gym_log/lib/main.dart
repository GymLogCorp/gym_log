import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymLog',
      home: Scaffold(
        backgroundColor: Color(0xFF1E1E1E),
        body: Center(
          child: Container(
            child: Image.asset('images/logoSemFundo.jpeg'),
          ),
        ),
      ),
    );
  }
}
