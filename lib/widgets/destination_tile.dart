/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Reusable widget for displaying a destination in the list.

import 'package:flutter/material.dart';
import '../models/destination.dart';

/// A reusable tile to display destination info in lists.
class DestinationTile extends StatelessWidget {
  final Destination destination;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  DestinationTile({
    required this.destination,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(destination.imageUrl,
          width: 60, height: 60, fit: BoxFit.cover),
      title: Text(destination.name),
      subtitle: Text(destination.country),
      trailing: IconButton(
        icon: Icon(
          destination.isFavorite ? Icons.star : Icons.star_border,
          color: destination.isFavorite ? Colors.amber : Colors.grey,
        ),
        onPressed: onFavoriteToggle,
      ),
      onTap: onTap,
    );
  }
}
