/// Course: MAD201
/// Assignment 01
/// Student: Ramandeep Singh - A00194321
/// Home screen displaying list of destinations with favorites and search.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/destination.dart';
import '../widgets/destination_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  String _sortOption = 'Name'; // Options: Name, Country, Rating

  /// Handles search query changes and triggers rebuild.
  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value.trim();
    });
  }

  /// Sorts the destination list based on the selected option.
  List<Destination> _sortDestinations(List<Destination> list) {
    switch (_sortOption) {
      case 'Country':
        list.sort((a, b) => a.country.compareTo(b.country));
        break;
      case 'Rating':
        list.sort((a, b) {
          double aRating = (a is TouristDestination) ? a.rating : 0;
          double bRating = (b is TouristDestination) ? b.rating : 0;
          return bRating.compareTo(aRating);
        });
        break;
      case 'Name':
      default:
        list.sort((a, b) => a.name.compareTo(b.name));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<TravelAppState>(context);
    List<Destination> destinations = appState.destinations;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      destinations = destinations.where((d) {
        return d.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            d.country.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Sort the list
    destinations = _sortDestinations(destinations);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Destinations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DestinationSearchDelegate(appState),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Dropdown for sort options
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _sortOption,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _sortOption = value;
                  });
                }
              },
              items: ['Name', 'Country', 'Rating']
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList(),
            ),
          ),

          // Destination list
          Expanded(
            child: ListView.builder(
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final dest = destinations[index];
                return DestinationTile(
                  destination: dest,
                  onFavoriteToggle: () {
                    appState.toggleFavorite(dest);
                  },
                  onTap: () async {
                    final updatedDestination = await Navigator.pushNamed(
                        context, '/details',
                        arguments: dest);
                    if (updatedDestination != null &&
                        updatedDestination is Destination) {
                      setState(() {
                        // Data is reflected via app state notifier usually,
                        // but local setState to refresh for safety.
                      });
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
        onTap: (index) {
          switch (index) {
            case 0:
              // Already here
              break;
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
      drawer: _buildDrawer(context),
    );
  }

  /// Builds app drawer with Settings, Help, About options.
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            title: const Text('Help'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help is coming soon!')),
              );
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/about');
            },
          )
        ],
      ),
    );
  }
}

/// Custom SearchDelegate for destinations
class DestinationSearchDelegate extends SearchDelegate {
  final TravelAppState appState;

  DestinationSearchDelegate(this.appState);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    final results = appState.destinations.where((d) {
      return d.name.toLowerCase().contains(query.toLowerCase()) ||
          d.country.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView(
      children: results
          .map((dest) => ListTile(
                title: Text(dest.name),
                subtitle: Text(dest.country),
                onTap: () {
                  close(context, dest);
                  Navigator.pushNamed(context, '/details', arguments: dest);
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
