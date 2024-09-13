import 'package:flutter/material.dart';
import 'package:gym_log/components/input.dart';
import 'package:gym_log/components/button.dart';
import 'package:gym_log/pages/login.dart';

class Register extends StatelessWidget {
  const Register({super.key});
  void navigateToLogin(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF1C1C21),
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView(
              children: [
                Image.asset('assets/images/logo_branca_sem_fundo.png'),
                Column(
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    const InputField(
                        labelText: 'Insira seu nome completo',
                        title: 'Nome Copmleto'),
                    const InputField(
                        labelText: 'Insira seu email', title: 'Email'),
                    const InputField(
                        labelText: 'Insira sua senha', title: 'Senha'),
                    const InputField(
                        labelText: 'Inseria sua senha',
                        title: 'Confirmar senha'),
                    const SizedBox(height: 25.0),
                    Button(
                      label: 'Cadastrar',
                      bgColor: 0xFF617AFA,
                      textColor: 0xFFFFFFFF,
                      borderColor: 0xFF617AFA,
                      onPressedProps: () {
                        navigateToLogin(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
