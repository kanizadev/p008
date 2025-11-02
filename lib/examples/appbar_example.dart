/// AppBar Example
///
/// Demonstrates various AppBar configurations and styles in Flutter.
/// This example showcases:
/// - Basic AppBar with title
/// - AppBar with action buttons
/// - Gradient AppBar with custom styling
/// - AppBar with custom leading widget
/// - Transparent AppBar with extendBodyBehindAppBar
/// - AppBar with bottom widget (TabBar integration)
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => AppBarExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget showcasing different AppBar variations.
///
/// Displays a list of interactive cards, each demonstrating a different
/// AppBar configuration. Tapping a card navigates to a full-screen example.
class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AppBar Variations')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              context,
              'Basic AppBar',
              'Simple app bar with title',
              Icons.apps,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('Basic AppBar')),
                    body: const Center(child: Text('Basic AppBar Example')),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'AppBar with Actions',
              'AppBar with action buttons',
              Icons.more_vert,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(
                      title: const Text('AppBar with Actions'),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                          tooltip: 'Search',
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                          tooltip: 'More options',
                        ),
                      ],
                    ),
                    body: const Center(
                      child: Text('AppBar with Action Buttons'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'Gradient AppBar',
              'AppBar with gradient background',
              Icons.gradient,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(
                      title: const Text('Gradient AppBar'),
                      flexibleSpace: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF87AE73), // Sage green
                              Color(0xFF6B8E5A), // Darker sage green
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    body: const Center(child: Text('Gradient AppBar Example')),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'AppBar with Leading',
              'Custom leading widget',
              Icons.arrow_back,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {},
                      ),
                      title: const Text('Custom Leading'),
                    ),
                    body: const Center(
                      child: Text('AppBar with Custom Leading'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'Transparent AppBar',
              'AppBar with transparent background',
              Icons.visibility_off,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: const Text(
                        'Transparent AppBar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      iconTheme: const IconThemeData(color: Colors.white),
                    ),
                    body: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF87AE73), // Sage green
                            Color(0xFF6B8E5A), // Darker sage green
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Transparent AppBar Example',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'AppBar with Bottom',
              'AppBar with bottom widget (TabBar)',
              Icons.view_carousel,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => _AppBarWithBottomExample()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a card section for each AppBar variation.
  ///
  /// [title] - The main title of the section
  /// [subtitle] - A brief description of the AppBar variation
  /// [icon] - Icon to display in the card
  /// [onTap] - Callback function when the card is tapped
  Widget _buildSection(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// AppBar with Bottom example using TabBar.
///
/// Demonstrates AppBar with bottom widget (TabBar) integration.
class _AppBarWithBottomExample extends StatefulWidget {
  const _AppBarWithBottomExample();

  @override
  State<_AppBarWithBottomExample> createState() =>
      _AppBarWithBottomExampleState();
}

class _AppBarWithBottomExampleState extends State<_AppBarWithBottomExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar with Bottom'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.search), text: 'Search'),
            Tab(icon: Icon(Icons.person), text: 'Profile'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent('Home Tab', Icons.home, const Color(0xFF87AE73)),
          _buildTabContent('Search Tab', Icons.search, const Color(0xFF7BA368)),
          _buildTabContent(
            'Profile Tab',
            Icons.person,
            const Color(0xFF6B8E5A),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
