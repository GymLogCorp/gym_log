import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_log/Exceptions/auth_exception.dart';
import 'package:gym_log/components/input.dart';
import 'package:gym_log/components/button.dart';
import 'package:gym_log/pages/layout.dart';
import 'package:gym_log/pages/login.dart';
import 'package:gym_log/pages/welcome.dart';
import 'package:gym_log/services/auth_service.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // chave global para acessar o estado do formulário
  final _formKey = GlobalKey<FormState>();
// tudo que for controler e uma instâncias da classe TextEditingController
// que e usado para controlar/monitorar o estado o conteudo dos campos de texto

  // controladores para os campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool loading = false;

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
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

  // funcao que valida email
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

  // funcao que valida senha e confirma
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha é obrigatória';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'A confirmação da senha é obrigatória';
    }
    if (value != _passwordController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  register() async {
    setState(() => loading = true);
    try {
      if (_formKey.currentState!.validate()) {
        await context.read<AuthService>().createAccount(_nameController.text,
            _emailController.text, _passwordController.text);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Layout()),
          );
        }
      }
    } on AuthException catch (e) {
      setState(() => loading = false);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C21),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
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
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Image.asset(
                'assets/images/logo_branca_sem_fundo.png',
                width: 180,
                height: 180,
              ),
              Column(
                children: [
                  const SizedBox(height: 26.0),
                  Form(
                    key: _formKey, // chave do formulário
                    child: Column(
                      children: [
                        CustomTextFormField(
                          placeholder: 'Insira seu nome completo',
                          title: 'Nome Completo',
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O nome é obrigatório';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          placeholder: 'Insira seu email',
                          title: 'Email',
                          controller: _emailController,
                          validator: _validateEmail, // validacao email
                        ),
                        CustomTextFormField(
                          placeholder: 'Insira sua senha',
                          title: 'Senha',
                          obscureText: true,
                          controller: _passwordController,
                          validator: _validatePassword, // validacao de senha
                        ),
                        CustomTextFormField(
                          placeholder: 'Confirme sua senha',
                          title: 'Confirmar Senha',
                          obscureText: true,
                          controller: _confirmPasswordController,
                          validator: _validateConfirmPassword, // confirma senha
                        ),
                        const SizedBox(height: 35.0),
                        Button(
                          label: 'CADASTRAR',
                          bgColor: 0xFF617AFA,
                          textColor: 0xFFFFFFFF,
                          borderColor: 0xFF617AFA,
                          width: 100,
                          height: 100,
                          onPressed: () {
                            register();
                          },
                          isLoading: loading, // envia essa bomba
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 35.0)),
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: 'Já possui conta? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                    ),
                    TextSpan(
                        text: 'Faça o login.',
                        style: const TextStyle(
                          color: Color(0xFF617AFA),
                          decoration: TextDecoration.underline,
                          fontSize: 18.0,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            navigateToLogin(context);
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
