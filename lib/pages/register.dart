import 'package:flutter/material.dart';
import 'package:gym_log/components/input.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF1C1C21),
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/logo_branca_sem_fundo.png'),
                Column(
                  children: [InputField(labelText: 'Insira seu nome')],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
