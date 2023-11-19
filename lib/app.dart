import 'package:flutter/material.dart';
import 'package:todo_firebase/utils/extensions.dart';

import 'screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: context.appTheme.darkTheme,
      theme: context.appTheme.lightTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
