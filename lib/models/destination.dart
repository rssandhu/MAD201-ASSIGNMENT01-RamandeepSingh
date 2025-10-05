/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Defines destination data models using Dart OOP principles.

class Destination {
  final String name;
  final String country;
  final String description;
  final String imageUrl;
  bool isFavorite;
  bool isVisited;

  Destination({
    required this.name,
    required this.country,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
    this.isVisited = false,
  });

  /// Toggle favorite status.
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  /// Mark destination as visited.
  void markVisited() {
    isVisited = true;
  }
}

/// Tourist destination with rating.
class TouristDestination extends Destination {
  final double rating;

  TouristDestination({
    required String name,
    required String country,
    required String description,
    required String imageUrl,
    this.rating = 0,
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

/// Cultural destination with famous food.
class CulturalDestination extends Destination {
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
