import 'package:flutter/material.dart';
import 'package:gym_log/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_log/repositories/user_repository.dart';
import 'package:gym_log/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //isso aqui permite que nós tenhamos um state global na aplicação onde qualquer componente pode escutar.
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserRepository()),
      ChangeNotifierProvider(create: (context) => AuthService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}
