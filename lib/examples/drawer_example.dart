/// Drawer Example
///
/// Demonstrates different drawer implementations in Flutter.
/// This example showcases:
/// - Standard Drawer (left side) with header and menu items
/// - End Drawer (right side) for secondary actions
/// - Custom Drawer with gradient header and styled menu items
///
/// Drawers are commonly used for:
/// - Main navigation menus
/// - User profiles and settings
/// - Quick actions and shortcuts
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => DrawerExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget showcasing different drawer implementations.
///
/// Displays three types of drawers:
/// 1. Standard Drawer - Left side with user profile header
/// 2. End Drawer - Right side for quick actions
/// 3. Custom Drawer - Styled drawer with gradient header
class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drawer Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              context,
              'Standard Drawer',
              'Material Design drawer with menu items',
              Icons.menu,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('Standard Drawer')),
                    drawer: _buildStandardDrawer(context),
                    body: const Center(
                      child: Text(
                        'Swipe from left or tap menu icon to open drawer',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'End Drawer',
              'Drawer from the right side',
              Icons.menu_open,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('End Drawer')),
                    endDrawer: _buildEndDrawer(context),
                    body: const Center(
                      child: Text(
                        'Swipe from right or tap menu icon to open drawer',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'Custom Drawer',
              'Drawer with custom styling and header',
              Icons.palette,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: const Text('Custom Drawer')),
                    drawer: _buildCustomDrawer(context),
                    body: const Center(
                      child: Text('Custom styled drawer with header'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a standard Material Design drawer.
  ///
  /// Features:
  /// - DrawerHeader with gradient background
  /// - User profile section (avatar, name, email)
  /// - List of menu items with icons
  /// - Divider separating sections
  /// - Logout option at the bottom
  Widget _buildStandardDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(radius: 30, child: Icon(Icons.person, size: 40)),
                SizedBox(height: 12),
                Text(
                  'User Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// Builds an end drawer (right side).
  ///
  /// Features:
  /// - Simpler header design
  /// - Quick action items (Share, Print, Download)
  /// - Useful for secondary navigation or actions
  Widget _buildEndDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.print),
            title: const Text('Print'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Download'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// Builds a custom styled drawer.
  ///
  /// Features:
  /// - Gradient header with app branding
  /// - Custom menu items in card format
  /// - Modern Material 3 styling
  /// - Expanded list view for flexibility
  Widget _buildCustomDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.apps, color: Colors.white, size: 48),
                  SizedBox(height: 12),
                  Text(
                    'Flutter Examples',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDrawerItem(
                  context,
                  Icons.dashboard,
                  'Dashboard',
                  () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  context,
                  Icons.analytics,
                  'Analytics',
                  () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  context,
                  Icons.notifications,
                  'Notifications',
                  () => Navigator.pop(context),
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  Icons.info,
                  'About',
                  () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  context,
                  Icons.privacy_tip,
                  'Privacy',
                  () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
