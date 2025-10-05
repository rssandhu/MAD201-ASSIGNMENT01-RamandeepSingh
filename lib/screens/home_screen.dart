/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Home screen displaying list of destinations with favorites and search.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/destination.dart';
import '../widgets/destination_tile.dart';

/// Home screen: List destinations with search, sort, favorites.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  String _sortOption = 'Name';

  /// Builds dropdown to select sorting option.
  Widget _buildSortDropdown() {
    return DropdownButton<String>(
      value: _sortOption,
      items: ['Name', 'Country', 'Rating'].map((option) {
        return DropdownMenuItem(value: option, child: Text(option));
      }).toList(),
      onChanged: (value) {
        setState(() {
          if (value != null) _sortOption = value;
        });
      },
    );
  }

  /// Filters and sorts destinations based on search and sort.
  List<Destination> _applyFiltersAndSort(List<Destination> destinations) {
    var filtered = destinations.where((dest) {
      return dest.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dest.country.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    filtered.sort((a, b) {
      switch (_sortOption) {
        case 'Country':
          return a.country.compareTo(b.country);
        case 'Rating':
          double aRating = a is TouristDestination ? a.rating : 0;
          double bRating = b is TouristDestination ? b.rating : 0;
          return bRating.compareTo(aRating);
        default:
          return a.name.compareTo(b.name);
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<TravelAppState>(context);

    List<Destination> filteredDestinations =
        _applyFiltersAndSort(appState.destinations);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Destinations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final selectedDest = await showSearch<Destination?>(
                context: context,
                delegate: DestinationSearch(appState.destinations),
              );
              if (selectedDest != null) {
                Navigator.pushNamed(context, '/details',
                    arguments: selectedDest);
              }
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSortDropdown(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDestinations.length,
              itemBuilder: (context, index) {
                final dest = filteredDestinations[index];
                return DestinationTile(
                  destination: dest,
                  onFavoriteToggle: () {
                    appState.toggleFavorite(dest);
                  },
                  onTap: () async {
                    final updatedDest = await Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: dest,
                    );
                    if (updatedDest != null && updatedDest is Destination) {
                      setState(() {}); // Refresh UI on return
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (idx) {
          switch (idx) {
            case 1:
              Navigator.pushNamed(context, '/bookings');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  /// Builds Drawer with menu entries.
  Widget _buildDrawer(BuildContext context) => Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Help is coming soon!')));
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () => Navigator.pushNamed(context, '/about'),
            ),
          ],
        ),
      );
}

/// SearchDelegate for destinations search.
class DestinationSearch extends SearchDelegate<Destination?> {
  final List<Destination> destinations;

  DestinationSearch(this.destinations);

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) {
    final results = destinations
        .where((dest) =>
            dest.name.toLowerCase().contains(query.toLowerCase()) ||
            dest.country.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, index) {
        final dest = results[index];
        return ListTile(
          title: Text(dest.name),
          subtitle: Text(dest.country),
          onTap: () => close(context, dest),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
