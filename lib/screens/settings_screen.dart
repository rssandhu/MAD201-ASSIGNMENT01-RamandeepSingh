/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Settings screen for app preferences including dark mode.

import 'package:flutter/material.dart';

/// Settings screen allowing the user to toggle dark mode.
class SettingsScreen extends StatelessWidget {
  final VoidCallback toggleThemeCallback;
  SettingsScreen({required this.toggleThemeCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Toggle Dark Mode'),
              trailing: Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (val) {
                  toggleThemeCallback();
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Settings Placeholder', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
