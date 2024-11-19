import 'package:flutter/material.dart';
import 'package:gym_log/pages/layout.dart';
import 'package:gym_log/pages/welcome.dart';
import 'package:gym_log/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, _) {
        if (authService.isLoading) {
          print("LOADING-----------------$authService.usuario----------------");
          return loading();
        } else if (authService.usuario != null) {
          print("LAYOUT----------------$authService.usuario-----------------");
          return const Layout();
        } else {
          print("WELCOME----------------$authService.usuario-----------------");
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
