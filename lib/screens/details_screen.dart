/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Screen for viewing/editing details of a destination.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/destination.dart';
import '../app_state.dart';

/// Details screen showing full details for a [Destination].
class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Destination dest =
        ModalRoute.of(context)?.settings.arguments as Destination;
    final appState = Provider.of<TravelAppState>(context);

    /// Returns badge widget if destination is visited.
    Widget _visitedBadge() {
      return Positioned(
        top: 10,
        right: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: const Text(
            'Visited',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    /// Handles marking as visited and returns data to home via pop.
    void _markVisited() {
      appState.markVisited(dest);
      Navigator.pop(context, dest);
    }

    /// Handles toggling favorite status.
    void _addToFavorites() {
      appState.toggleFavorite(dest);
    }

    return Scaffold(
      appBar: AppBar(title: Text(dest.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(dest.imageUrl,
                    width: double.infinity, height: 220, fit: BoxFit.cover),
                if (dest.isVisited) _visitedBadge(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dest.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(dest.country, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(dest.description),
                  const SizedBox(height: 20),
                  if (dest is TouristDestination)
                    Text(
                        'Rating: ${(dest as TouristDestination).rating.toString()}'),
                  if (dest is CulturalDestination)
                    Text(
                        'Famous Food: ${(dest as CulturalDestination).famousFood}'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: dest.isVisited ? null : _markVisited,
                        child: const Text('Mark as Visited'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _addToFavorites,
                        child: Text(dest.isFavorite
                            ? 'Remove Favorite'
                            : 'Add to Favorites'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
