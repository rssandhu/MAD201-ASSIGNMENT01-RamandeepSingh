/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Defines destination data models using Dart OOP principles.

/// Base class representing a travel destination.
class Destination {
  /// Name of the destination.
  final String name;

  /// Country of the destination.
  final String country;

  /// Detailed description of the destination.
  final String description;

  /// Image URL representing the destination.
  final String imageUrl;

  /// Whether this destination is marked as favorite.
  bool isFavorite;

  /// Whether the destination has been marked as visited.
  bool isVisited;

  /// Constructor for base Destination class.
  Destination({
    required this.name,
    required this.country,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
    this.isVisited = false,
  });

  /// Toggles the favorite status.
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  /// Marks the destination as visited.
  void markVisited() {
    isVisited = true;
  }
}

/// Tourist destination subclass adding a rating property.
class TouristDestination extends Destination {
  /// User rating of the destination.
  final double rating;

  TouristDestination({
    required String name,
    required String country,
    required String description,
    required String imageUrl,
    this.rating = 0.0,
    bool isFavorite = false,
    bool isVisited = false,
  }) : super(
          name: name,
          country: country,
          description: description,
          imageUrl: imageUrl,
          isFavorite: isFavorite,
          isVisited: isVisited,
        );
}

/// Cultural destination subclass adding a famous food property.
class CulturalDestination extends Destination {
  /// Famous food related to the destination.
  final String famousFood;

  CulturalDestination({
    required String name,
    required String country,
    required String description,
    required String imageUrl,
    required this.famousFood,
    bool isFavorite = false,
    bool isVisited = false,
  }) : super(
          name: name,
          country: country,
          description: description,
          imageUrl: imageUrl,
          isFavorite: isFavorite,
          isVisited: isVisited,
        );
}
