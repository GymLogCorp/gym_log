import 'package:flutter/material.dart';
import 'package:gym_log/ui/auth/view_models/auth_viewmodel.dart';
import 'package:gym_log/ui/layout/widgets/layout_screen.dart';
import 'package:gym_log/ui/welcome/widgets/welcome_screen.dart';
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
