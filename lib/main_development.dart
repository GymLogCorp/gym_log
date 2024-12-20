import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym_log/presentation/screens/layout/layout_screen.dart';
import 'package:gym_log/providers/auth_provider.dart';
import 'package:gym_log/providers/exercise_provider.dart';
import 'package:gym_log/providers/historic_provider.dart';

import 'package:gym_log/providers/session_provider.dart';
import 'package:gym_log/providers/workout_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Pra rodar com o device preview
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => WorkoutProvider()),
        ChangeNotifierProvider(create: (context) => ExerciseProvider()),
        ChangeNotifierProvider(create: (context) => HistoricProvider()),
        ChangeNotifierProvider(create: (context) => SessionProvider())
      ],
      child: const MyApp(),
    ),
  ));
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
          home: const Layout(),
        );
      },
    );
  }
}
