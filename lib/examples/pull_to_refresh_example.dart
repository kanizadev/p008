/// Pull to Refresh Example
///
/// Demonstrates pull-to-refresh functionality in Flutter.
/// This example showcases:
/// - RefreshIndicator: Swipe down to refresh
/// - Loading states: Displaying during refresh
/// - List updates: Dynamically updating list content
/// - Adding items: FloatingActionButton to add new items
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => PullToRefreshExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating pull-to-refresh functionality.
///
/// Shows how to implement swipe-to-refresh for lists.
class PullToRefreshExample extends StatefulWidget {
  const PullToRefreshExample({super.key});

  @override
  State<PullToRefreshExample> createState() => _PullToRefreshExampleState();
}

class _PullToRefreshExampleState extends State<PullToRefreshExample> {
  final List<String> _items = [];
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    setState(() {
      _items.clear();
      for (int i = 0; i < 10; i++) {
        _items.add('Item ${_counter * 10 + i + 1}');
      }
      _counter++;
    });
  }

  Future<void> _onRefresh() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _counter = 0;
    });
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pull to Refresh')),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.primary,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(_items[index]),
                subtitle: Text('Swipe down to refresh'),
                trailing: const Icon(Icons.chevron_right),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _items.add('New Item ${_items.length + 1}');
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Item added!')));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
