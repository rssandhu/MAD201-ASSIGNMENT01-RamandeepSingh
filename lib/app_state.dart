/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Central application state managing destinations and user profile.

import 'package:flutter/material.dart';
import 'models/destination.dart';
import 'repositories/destination_repository.dart';

/// Global app state using ChangeNotifier for UI updates.
class TravelAppState extends ChangeNotifier {
  final DestinationRepository _repository = DestinationRepository();

  bool isDarkMode = false;

  String userName = 'Kate';
  int travelerLevel = 1;
  String profileImage = 'assets/images/profile.jpg';

  /// Returns all destinations.
  List<Destination> get destinations => _repository.getAllDestinations();

  /// Returns destinations marked as visited.
  List<Destination> get visitedDestinations =>
      destinations.where((d) => d.isVisited).toList();

  /// Returns destinations marked as favorite.
  List<Destination> get favoriteDestinations =>
      destinations.where((d) => d.isFavorite).toList();

  /// Toggles dark mode state.
  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  /// Toggles favorite for [dest].
  void toggleFavorite(Destination dest) {
    _repository.toggleFavorite(dest);
    notifyListeners();
  }

  /// Marks [dest] as visited.
  void markVisited(Destination dest) {
    _repository.markVisited(dest);
    notifyListeners();
  }

  /// Returns all visited countries.
  Set<String> getVisitedCountries() => _repository.getVisitedCountries();
}
