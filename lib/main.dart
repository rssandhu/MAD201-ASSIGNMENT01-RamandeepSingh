/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Main app entry point with routing and theme management.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TravelAppState(),
      child: TravelAppRoot(),
    ),
  );
}

class TravelAppRoot extends StatefulWidget {
  @override
  State<TravelAppRoot> createState() => _TravelAppRootState();
}

class _TravelAppRootState extends State<TravelAppRoot> {
  ThemeMode _themeMode = ThemeMode.light;

  /// Toggles light/dark mode and rebuilds UI.
  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
