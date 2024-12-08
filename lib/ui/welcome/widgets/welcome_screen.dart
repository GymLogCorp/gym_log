import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/ui/auth/widgets/register_screen.dart';
import 'package:gym_log/ui/core/widgets/button.dart';
// import 'package:gym_log/pages/layout.dart';
// Comentado para n precisar usar a autenticação
import 'package:gym_log/ui/auth/widgets/login_screen.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  void navigateToRegister(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C21),
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/logo_branca_sem_fundo.png'),
              Text(
                'Mais um treino\nMais um registro',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 35.0,
              ),
              Column(children: [
                Button(
                  label: 'ENTRAR',
                  bgColor: 0xFF617AFA,
                  textColor: 0xFFFFFFFF,
                  borderColor: 0xFF617AFA,
                  width: 268,
                  height: 68,
                  onPressed: () {
                    navigateToLogin(
                        context); //não ta funcionando, verificar o que é dps
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Button(
                  label: 'CADASTRAR',
                  bgColor: 0xFF212429,
                  textColor: 0xFFFFFFFF,
                  borderColor: 0xFF4F5461,
                  width: 268,
                  height: 68,
                  onPressed: () {
                    navigateToRegister(context);
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
