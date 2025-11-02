/// TabBar Example
///
/// Demonstrates various TabBar implementations in Flutter.
/// This example showcases:
/// - Default TabBar with text tabs
/// - TabBar with icons and labels
/// - Scrollable TabBar for many tabs
/// - TabBar positioned in body (not AppBar)
///
/// TabBar is used for:
/// - Organizing content into sections
/// - Horizontal navigation between views
/// - Creating tabbed interfaces
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => TabBarExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget showcasing different TabBar implementations.
///
/// Each example demonstrates a different TabBar configuration:
/// - Default TabBar - Standard implementation in AppBar
/// - TabBar with Icons - Combining icons with text labels
/// - Scrollable TabBar - Horizontal scrolling for many tabs
/// - TabBar in Body - Custom positioning within body
class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TabBar Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              context,
              'Default TabBar',
              'Standard Material Design tab bar',
              Icons.tab,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('Default TabBar'),
                        bottom: const TabBar(
                          tabs: [
                            Tab(text: 'Tab 1'),
                            Tab(text: 'Tab 2'),
                            Tab(text: 'Tab 3'),
                          ],
                        ),
                      ),
                      body: const TabBarView(
                        children: [
                          _TabContent('Tab 1', Colors.blue),
                          _TabContent('Tab 2', Colors.green),
                          _TabContent('Tab 3', Colors.orange),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'TabBar with Icons',
              'TabBar with icons and labels',
              Icons.label,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('TabBar with Icons'),
                        bottom: const TabBar(
                          tabs: [
                            Tab(icon: Icon(Icons.home), text: 'Home'),
                            Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
                            Tab(icon: Icon(Icons.settings), text: 'Settings'),
                          ],
                        ),
                      ),
                      body: const TabBarView(
                        children: [
                          _TabContent('Home Tab', Colors.red),
                          _TabContent('Favorites Tab', Colors.pink),
                          _TabContent('Settings Tab', Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'Scrollable TabBar',
              'TabBar that scrolls horizontally',
              Icons.swipe,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DefaultTabController(
                    length: 6,
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('Scrollable TabBar'),
                        bottom: const TabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(text: 'Tab 1'),
                            Tab(text: 'Tab 2'),
                            Tab(text: 'Tab 3'),
                            Tab(text: 'Tab 4'),
                            Tab(text: 'Tab 5'),
                            Tab(text: 'Tab 6'),
                          ],
                        ),
                      ),
                      body: const TabBarView(
                        children: [
                          _TabContent('Tab 1', Colors.blue),
                          _TabContent('Tab 2', Colors.green),
                          _TabContent('Tab 3', Colors.orange),
                          _TabContent('Tab 4', Colors.purple),
                          _TabContent('Tab 5', Colors.teal),
                          _TabContent('Tab 6', Colors.red),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'TabBar in Body',
              'TabBar positioned in the body',
              Icons.view_column,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(title: const Text('TabBar in Body')),
                      body: Column(
                        children: [
                          Container(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            child: const TabBar(
                              tabs: [
                                Tab(text: 'First'),
                                Tab(text: 'Second'),
                                Tab(text: 'Third'),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: TabBarView(
                              children: [
                                _TabContent('First Tab', Colors.blue),
                                _TabContent('Second Tab', Colors.green),
                                _TabContent('Third Tab', Colors.orange),
                              ],
                            ),
                          ),
                        ],
                      ),
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
}

/// Content widget displayed in each tab.
///
/// [title] - Title to display in the tab content
/// [color] - Theme color for the tab content
class _TabContent extends StatelessWidget {
  /// Title of the tab content
  final String title;

  /// Theme color for styling
  final Color color;

  const _TabContent(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withValues(alpha: 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: color),
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
