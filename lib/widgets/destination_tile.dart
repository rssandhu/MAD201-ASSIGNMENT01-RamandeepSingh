/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Reusable widget for displaying a destination in the list.

import 'package:flutter/material.dart';
import '../models/destination.dart';

class DestinationTile extends StatelessWidget {
  final Destination destination;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  /// Creates a destination tile with image, name, country and favorite toggle.
  DestinationTile({
    required this.destination,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(destination.imageUrl,
          width: 60, height: 60, fit: BoxFit.cover),
      title: Text(destination.name),
      subtitle: Text(destination.country),
      trailing: IconButton(
        icon: Icon(
          destination.isFavorite ? Icons.star : Icons.star_border,
          color: destination.isFavorite ? Colors.yellow[700] : Colors.grey,
        ),
        onPressed: onFavoriteToggle,
      ),
      onTap: onTap,
    );
  }
}
