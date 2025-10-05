/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Main app entry point with routing and theme management.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/bookings_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => TravelAppState(),
    child: TravelApp(),
  ));
}

/// Root of the application, manages theme and routing.
class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<TravelAppState>(context);

    return MaterialApp(
      title: 'Travel Destinations',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/details': (_) => DetailsScreen(),
        '/profile': (_) => ProfileScreen(),
        '/bookings': (_) => BookingsScreen(),
        '/settings': (context) => SettingsScreen(
              toggleThemeCallback:
                  Provider.of<TravelAppState>(context, listen: false)
                      .toggleDarkMode,
            ),
        '/about': (_) => AboutScreen(),
      },
    );
  }
}
