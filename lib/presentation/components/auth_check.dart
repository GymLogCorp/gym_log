import 'package:flutter/material.dart';
import 'package:gym_log/providers/auth_provider.dart';
import 'package:gym_log/presentation/screens/layout/layout_screen.dart';
import 'package:gym_log/presentation/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, _) {
        if (authService.isLoading) {
          return loading();
        } else if (authService.usuario != null) {
          return const Layout();
        } else {
          return const Welcome();
        }
      },
    );
  }

  Widget loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
