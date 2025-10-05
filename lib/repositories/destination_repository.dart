/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Repository to manage destinations data logic.

import '../models/destination.dart';

/// Repository class holding destinations list and methods to interact with it.
class DestinationRepository {
  /// Internal list holding the destinations.
  final List<Destination> _destinations = [];

  /// Gets all destinations as a list.
  List<Destination> getAllDestinations() => _destinations;

  /// Toggles the favorite status of a given destination [d].
  void toggleFavorite(Destination d) {
    d.toggleFavorite();
  }

  /// Marks a destination [d] as visited.
  void markVisited(Destination d) {
    d.markVisited();
  }

  /// Returns a set of countries that have been visited.
  Set<String> getVisitedCountries() {
    return _destinations
        .where((d) => d.isVisited)
        .map((d) => d.country)
        .toSet();
  }

  /// Adds a new destination to the list.
  void addDestination(Destination dest) {
    _destinations.add(dest);
  }
}
