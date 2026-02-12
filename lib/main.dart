import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/custom_theme.dart';
import 'package:frontend_hackathon_mobile/configs/routes.dart';

import 'configs/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindEase',
      theme: ThemeData.from(colorScheme: CustomTheme.lightScheme()),
      darkTheme: ThemeData.from(colorScheme: CustomTheme.darkScheme()),
      themeMode: ThemeMode.system,
      routes: Routes().routes,
    );
  }
}
