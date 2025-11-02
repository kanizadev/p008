/// Search & Filter Example
///
/// Demonstrates real-time search and filtering functionality in Flutter.
/// This example showcases:
/// - Real-time search: Filtering as user types
/// - Filter chips: Category-based filtering
/// - Combined filters: Search + category filtering
/// - Empty state handling: Displaying when no results found
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => SearchFilterExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating search and filter functionality.
///
/// Shows how to implement real-time search with category filtering.
class SearchFilterExample extends StatefulWidget {
  const SearchFilterExample({super.key});

  @override
  State<SearchFilterExample> createState() => _SearchFilterExampleState();
}

class _SearchFilterExampleState extends State<SearchFilterExample> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<Map<String, String>> _allItems = [
    {'name': 'Apple', 'category': 'Fruit', 'color': 'Red'},
    {'name': 'Banana', 'category': 'Fruit', 'color': 'Yellow'},
    {'name': 'Carrot', 'category': 'Vegetable', 'color': 'Orange'},
    {'name': 'Tomato', 'category': 'Vegetable', 'color': 'Red'},
    {'name': 'Grapes', 'category': 'Fruit', 'color': 'Purple'},
    {'name': 'Lettuce', 'category': 'Vegetable', 'color': 'Green'},
    {'name': 'Orange', 'category': 'Fruit', 'color': 'Orange'},
    {'name': 'Broccoli', 'category': 'Vegetable', 'color': 'Green'},
    {'name': 'Strawberry', 'category': 'Fruit', 'color': 'Red'},
    {'name': 'Cucumber', 'category': 'Vegetable', 'color': 'Green'},
  ];

  List<Map<String, String>> get _filteredItems {
    return _allItems.where((item) {
      final matchesSearch = item['name']!.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesFilter =
          _selectedFilter == 'All' || item['category'] == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search & Filter')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ['All', 'Fruit', 'Vegetable'].map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    selectedColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No items found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getColor(item['color']!),
                            child: Text(
                              item['name']![0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(item['name']!),
                          subtitle: Text(
                            '${item['category']!} - ${item['color']!}',
                          ),
                          trailing: Chip(
                            label: Text(
                              item['category']!,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Color _getColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'green':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
