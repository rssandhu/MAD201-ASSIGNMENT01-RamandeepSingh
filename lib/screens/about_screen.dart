/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh- A00194321
/// About screen displaying app info.

import 'package:flutter/material.dart';

/// Static About screen with project details.
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Travel Destinations App\n\n'
            'Course: MAD201\n'
            'Assignment 01\n\n'
            'A sample Flutter app demonstrating Dart OOP,'
            'multi-screen UI, navigation, and app-wide state.',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
