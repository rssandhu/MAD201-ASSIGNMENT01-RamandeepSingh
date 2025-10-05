/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Central application state managing destinations and user profile.

import 'package:flutter/material.dart';
import 'models/destination.dart';
import 'repositories/destination_repository.dart';

/// Manages global app state including destinations and user data.
class TravelAppState extends ChangeNotifier {
  /// Repository handling destination data.
  final DestinationRepository repository = DestinationRepository();

  /// User name.
  String userName = 'Your Name';

  /// User's traveler level.
  int travelerLevel = 1;

  /// User profile picture asset path.
  String profileImage = 'assets/images/profile.jpg';

  /// Gets all destinations.
  List<Destination> get destinations => repository.getAllDestinations();

  /// Gets list of visited destinations.
  List<Destination> get visitedDestinations =>
      destinations.where((d) => d.isVisited).toList();

  /// Gets list of favorite destinations.
  List<Destination> get favoriteDestinations =>
      destinations.where((d) => d.isFavorite).toList();

  /// Toggles favorite status of [dest] and notifies listeners.
  void toggleFavorite(Destination dest) {
    repository.toggleFavorite(dest);
    notifyListeners();
  }

  /// Marks [dest] as visited and notifies listeners.
  void markVisited(Destination dest) {
    repository.markVisited(dest);
    notifyListeners();
  }

  /// Gets set of visited countries.
  Set<String> getVisitedCountries() => repository.getVisitedCountries();
}
