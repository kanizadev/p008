/// Navigation Bar Example
///
/// Demonstrates different navigation bar implementations in Flutter.
/// This example showcases:
/// - Material 3 NavigationBar (modern bottom navigation)
/// - Legacy BottomNavigationBar (classic style)
/// - NavigationRail (desktop-style side navigation)
///
/// Each example is interactive and demonstrates state management for
/// navigation index changes.
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => NavigationBarExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget showcasing different navigation bar implementations.
///
/// Displays three interactive examples:
/// 1. Material 3 NavigationBar - Modern Material Design 3 navigation
/// 2. BottomNavigationBar - Classic bottom navigation bar
/// 3. NavigationRail - Side navigation for larger screens
class NavigationBarExample extends StatefulWidget {
  const NavigationBarExample({super.key});

  @override
  State<NavigationBarExample> createState() => _NavigationBarExampleState();
}

class _NavigationBarExampleState extends State<NavigationBarExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Bar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              'Bottom Navigation Bar',
              'Material 3 navigation bar',
              Icons.navigation,
              _buildBottomNavBarExample(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Bottom Navigation Bar (Legacy)',
              'Classic bottom navigation bar',
              Icons.view_list,
              _buildLegacyBottomNavBarExample(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Navigation Rail',
              'Desktop-style navigation rail',
              Icons.train,
              _buildNavigationRailExample(),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a section card for each navigation bar type.
  ///
  /// [title] - Section title
  /// [subtitle] - Brief description
  /// [icon] - Icon for the section
  /// [content] - Widget content to display
  Widget _buildSection(
    String title,
    String subtitle,
    IconData icon,
    Widget content,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  /// Builds Material 3 NavigationBar example.
  ///
  /// Demonstrates the modern NavigationBar widget with:
  /// - Selected/unselected icon states
  /// - Labels for each destination
  /// - State management with _currentIndex
  Widget _buildBottomNavBarExample() {
    return Builder(
      builder: (context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Page ${_currentIndex + 1}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              NavigationBar(
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search_outlined),
                    selectedIcon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_outline),
                    selectedIcon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds classic BottomNavigationBar example.
  ///
  /// Demonstrates the legacy BottomNavigationBar with:
  /// - Fixed type (all items always visible)
  /// - Icon and label for each item
  /// - Traditional bottom navigation styling
  Widget _buildLegacyBottomNavBarExample() {
    return Builder(
      builder: (context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Page ${_currentIndex + 1}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds NavigationRail example.
  ///
  /// Demonstrates the side navigation rail with:
  /// - Vertical navigation layout
  /// - Labels displayed for all destinations
  /// - Divider separating rail from content
  /// - Ideal for tablet and desktop layouts
  Widget _buildNavigationRailExample() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search),
                label: Text('Search'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_outline),
                selectedIcon: Icon(Icons.favorite),
                label: Text('Favorites'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Profile'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: Text(
                'Page ${_currentIndex + 1}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
