/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Repository to manage destinations data logic.

import '../models/destination.dart';

/// Repository managing destinations collection and actions.
class DestinationRepository {
  final List<Destination> _destinations = [];

  DestinationRepository() {
    // Sample data added at initialization.
    addDestination(TouristDestination(
      name: 'Lake Tahoe',
      country: 'USA',
      description: 'Beautiful mountain lake in California.',
      imageUrl: 'assets/images/destination1.jpg',
      rating: 4.7,
    ));
    addDestination(CulturalDestination(
      name: 'Kyoto',
      country: 'Japan',
      description: 'Historic temples and traditional cuisine.',
      imageUrl: 'assets/images/destination2.jpg',
      famousFood: 'Kaiseki',
    ));
  }

  /// Returns the full list of destinations.
  List<Destination> getAllDestinations() => _destinations;

  /// Toggles favorite status for destination [d].
  void toggleFavorite(Destination d) {
    d.toggleFavorite();
  }

  /// Marks destination [d] as visited.
  void markVisited(Destination d) {
    d.markVisited();
  }

  /// Returns set of countries that have been visited.
  Set<String> getVisitedCountries() =>
      _destinations.where((d) => d.isVisited).map((d) => d.country).toSet();

  /// Adds a destination.
  void addDestination(Destination dest) => _destinations.add(dest);
}
