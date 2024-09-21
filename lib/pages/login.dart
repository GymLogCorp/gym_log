import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_log/components/input.dart';
import 'package:gym_log/components/button.dart';
import 'package:gym_log/pages/register.dart';
import 'package:gym_log/pages/welcome.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Register(),
      ),
    );
  }

  void navigateToWelcome(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Welcome(),
        ));
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'O email é obrigatório';
    }
    final emailRegex = RegExp(
        r'^[^@]+@[^@]+\.[^@]+'); //regex copiado hasMatch e pra ver se ta batendo com o regex
    if (!emailRegex.hasMatch(value)) {
      return 'Insira um email válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha é obrigatória';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // se tudo estiver ok vai para onde eu mandar
      // navigateToLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C21),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 36,
                    onPressed: () {
                      navigateToWelcome(context);
                    },
                  ),
                ],
              ),
              Image.asset(
                'assets/images/logo_branca_sem_fundo.png',
                width: 300,
                height: 300,
              ),
              Column(
                children: [
                  const SizedBox(height: 26.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: 'Digite seu email',
                          title: 'Email',
                          obscureText: false,
                          controller: _emailController,
                          validator: _validateEmail,
                        ),
                        CustomTextFormField(
                          hintText: 'Digite sua senha',
                          title: 'Senha',
                          obscureText: true,
                          controller: _passwordController,
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 35.0),
                        Button(
                            label: 'ENTRAR',
                            bgColor: 0xFF617AFA,
                            textColor: 0xFFFFFFFF,
                            borderColor: 0xFF617AFA,
                            onPressedProps: _submitForm),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 35.0)),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: 'Nâo possui uma conta ? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                    ),
                    TextSpan(
                        text: 'Cadastre-se',
                        style: const TextStyle(
                          color: Color(0xFF617AFA),
                          decoration: TextDecoration.underline,
                          fontSize: 18.0,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            navigateToRegister(context);
                          })
                  ]))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
