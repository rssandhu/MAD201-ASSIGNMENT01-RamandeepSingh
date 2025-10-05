/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Profile screen with tabs: User Info, Visited Destinations, and Stats.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/destination.dart';

/// Screen showing user profile and travel statistics with tab navigation.
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<TravelAppState>(context);

    /// Tab for user info.
    Widget _buildUserInfo() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 40, backgroundImage: AssetImage(appState.profileImage)),
            const SizedBox(height: 16),
            Text(appState.userName, style: const TextStyle(fontSize: 24)),
            Text('Traveler Level: ${appState.travelerLevel}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    /// Tab listing visited destinations.
    Widget _buildVisitedList() {
      if (appState.visitedDestinations.isEmpty) {
        return const Center(child: Text('No destinations visited yet.'));
      }
      return ListView(
        children: appState.visitedDestinations
            .map((dest) => ListTile(
                  title: Text(dest.name),
                  subtitle: Text(dest.country),
                ))
            .toList(),
      );
    }

    /// Tab for statistics about favorites and visited countries.
    Widget _buildStats() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Favorites: ${appState.favoriteDestinations.length}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Visited Countries: ${appState.getVisitedCountries().length}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Profile'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Info'),
                Tab(text: 'Visited'),
                Tab(text: 'Stats'),
              ],
            )),
        body: TabBarView(
          children: [
            _buildUserInfo(),
            _buildVisitedList(),
            _buildStats(),
          ],
        ),
      ),
    );
  }
}
