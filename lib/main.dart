import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_log/repositories/exercise_repository.dart';
import 'package:gym_log/repositories/session_repository.dart';
import 'package:gym_log/repositories/workout_repository.dart';
import 'package:gym_log/repositories/historic_repository.dart';

import 'package:gym_log/services/auth_service.dart';
import 'package:gym_log/states/SessionState.dart';
import 'package:gym_log/widgets/auth_check.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //isso aqui permite que nós tenhamos um state global na aplicação onde qualquer componente pode escutar.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => WorkoutRepository()),
        ChangeNotifierProvider(create: (context) => ExerciseRepository()),
        ChangeNotifierProvider(create: (context) => SessionRepository()),
        ChangeNotifierProvider(create: (context) => SessionState()),
        ChangeNotifierProvider(create: (context) => HistoricRepository()),
      ],
      child: const MyApp(),
    ),
  );
  //Pra rodar com o device preview
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (context) => AuthService()),
  //       ChangeNotifierProvider(create: (context) => WorkoutRepository()),
  //       ChangeNotifierProvider(create: (context) => ExerciseRepository()),
  //       ChangeNotifierProvider(create: (context) => SessionRepository()),
  //       ChangeNotifierProvider(create: (context) => HistoricRepository()),
  //       ChangeNotifierProvider(create: (context) => SessionState())
  //     ],
  //     child: const MyApp(),
  //   ),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, auth, _) {
        return MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          home: const AuthCheck(),
        );
      },
    );
  }
}
