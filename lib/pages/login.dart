import 'package:flutter/material.dart';
import 'package:gym_log/components/input.dart';
import 'package:gym_log/components/button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C21),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 48,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 300),
                const Spacer(flex: 1),
                const CustomTextFormField(
                  hintText: 'Digite seu email',
                  title: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                const CustomTextFormField(
                  hintText: 'Digite sua senha',
                  title: 'Senha',
                  obscureText: true,
                ),
                const Spacer(),
                SizedBox(
                  child: Button(
                    label: 'ENTRAR',
                    onPressedProps: () {},
                    bgColor: 0xFF617AFA,
                    textColor: 0xFFFFFFFF,
                    borderColor: 0xFF617AFA,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não possui uma conta?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Cadastre-se',
                          style: TextStyle(
                            color: Color(0xFF617AFA),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo_branca_sem_fundo.png',
                width: 400,
                height: 400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
