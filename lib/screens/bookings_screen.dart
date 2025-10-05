/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Placeholder screen for bookings.

import 'package:flutter/material.dart';

/// Placeholder bookings screen.
class BookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      body: const Center(
        child: Text('No bookings yet.', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
