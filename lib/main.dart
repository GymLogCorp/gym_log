import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_log/providers/auth_provider.dart';
import 'package:gym_log/providers/exercise_provider.dart';
import 'package:gym_log/providers/historic_provider.dart';

import 'package:gym_log/providers/session_provider.dart';
import 'package:gym_log/presentation/components/auth_check.dart';
import 'package:gym_log/providers/user_provider.dart';
import 'package:gym_log/providers/workout_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => WorkoutProvider()),
        ChangeNotifierProvider(create: (context) => ExerciseProvider()),
        ChangeNotifierProvider(create: (context) => SessionProvider()),
        ChangeNotifierProvider(create: (context) => HistoricProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, auth, _) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthCheck(),
        );
      },
    );
  }
}
