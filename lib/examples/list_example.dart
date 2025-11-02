/// List Example
///
/// Demonstrates various list and grid widgets in Flutter.
/// This example showcases:
/// - Simple ListView: Basic scrollable list
/// - Card List: ListView with styled card items
/// - Grid View: Two-dimensional grid layout
/// - Expandable List: ExpansionTile for nested/collapsible content
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => ListExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating different list and grid implementations.
///
/// Uses TabBarView to organize different list examples into tabs.
class ListExample extends StatelessWidget {
  const ListExample({super.key});

  final List<String> _items = const [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
  ];

  final List<Map<String, dynamic>> _data = const [
    {
      'title': 'Flutter',
      'subtitle': 'Google\'s UI toolkit',
      'icon': Icons.code,
    },
    {
      'title': 'Dart',
      'subtitle': 'Programming language',
      'icon': Icons.language,
    },
    {
      'title': 'Material Design',
      'subtitle': 'Design system',
      'icon': Icons.palette,
    },
    {'title': 'Widgets', 'subtitle': 'Building blocks', 'icon': Icons.widgets},
    {
      'title': 'State Management',
      'subtitle': 'Managing app state',
      'icon': Icons.settings,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List Examples'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Simple'),
              Tab(text: 'Cards'),
              Tab(text: 'Grid'),
              Tab(text: 'Expand'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSimpleList(),
            _buildCardList(),
            _buildGridList(),
            _buildExpandableList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleList() {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(_items[index]),
          subtitle: Text('Subtitle for ${_items[index]}'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Tapped ${_items[index]}')));
          },
        );
      },
    );
  }

  Widget _buildCardList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _data.length,
      itemBuilder: (context, index) {
        final item = _data[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                item['icon'] as IconData,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            title: Text(item['title'] as String),
            subtitle: Text(item['subtitle'] as String),
            trailing: IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Liked ${item['title']}')),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridList() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: _data.length,
      itemBuilder: (context, index) {
        final item = _data[index];
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item['icon'] as IconData,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                item['title'] as String,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  item['subtitle'] as String,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExpandableList() {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        final item = _data[index];
        return ExpansionTile(
          leading: Icon(item['icon'] as IconData),
          title: Text(item['title'] as String),
          subtitle: Text(item['subtitle'] as String),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'This is detailed information about ${item['title']}. '
                'You can add more content here to explain the item in detail.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('More info for ${item['title']}'),
                        ),
                      );
                    },
                    child: const Text('More Info'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
