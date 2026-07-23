import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/preferences_manager.dart';
import 'package:tasky_app/core/theme/light_theme.dart';
import 'package:tasky_app/features/home/home_screen.dart';
import 'package:tasky_app/features/navigation/main_screen.dart';
import 'package:tasky_app/features/welcome/welcome_screen.dart';

import 'core/theme/dark_theme.dart';
import 'core/theme/theme_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();

  ThemeController().init();

  String? username = PreferencesManager().getString("username");

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      }
    );
  }
}
