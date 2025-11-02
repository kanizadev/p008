/// Advanced List Example
///
/// Demonstrates advanced list implementations in Flutter.
/// This example showcases:
/// - ListView with pagination
/// - Infinite scroll
/// - List filtering and sorting
/// - Lazy loading
/// - Optimized list rendering
/// - List item animations
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => AdvancedListExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating advanced list patterns.
///
/// Shows pagination, infinite scroll, filtering, and sorting.
class AdvancedListExample extends StatefulWidget {
  const AdvancedListExample({super.key});

  @override
  State<AdvancedListExample> createState() => _AdvancedListExampleState();
}

class _AdvancedListExampleState extends State<AdvancedListExample> {
  final ScrollController _scrollController = ScrollController();
  final List<Item> _allItems = [];
  List<Item> _displayedItems = [];
  bool _isLoading = false;
  int _currentPage = 1;
  String _sortBy = 'name';
  String _filterQuery = '';

  @override
  void initState() {
    super.initState();
    _loadItems();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadItems() {
    setState(() => _isLoading = true);

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      final startIndex = (_currentPage - 1) * 20;
      final newItems = List.generate(20, (index) {
        final id = startIndex + index + 1;
        return Item(
          id: id,
          name: 'Item $id',
          category: _getCategory(id),
          price: (id * 10.5).toStringAsFixed(2),
        );
      });

      setState(() {
        if (_currentPage == 1) {
          _allItems.clear();
          _displayedItems.clear();
        }
        _allItems.addAll(newItems);
        _applyFilters();
        _isLoading = false;
      });
    });
  }

  String _getCategory(int id) {
    final categories = ['Electronics', 'Clothing', 'Food', 'Books', 'Toys'];
    return categories[id % categories.length];
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.9 &&
        !_isLoading) {
      _loadMore();
    }
  }

  void _loadMore() {
    setState(() {
      _currentPage++;
    });
    _loadItems();
  }

  void _applyFilters() {
    List<Item> filtered = List.from(_allItems);

    if (_filterQuery.isNotEmpty) {
      filtered = filtered
          .where((item) =>
              item.name.toLowerCase().contains(_filterQuery.toLowerCase()) ||
              item.category.toLowerCase().contains(_filterQuery.toLowerCase()))
          .toList();
    }

    filtered.sort((a, b) {
      switch (_sortBy) {
        case 'name':
          return a.name.compareTo(b.name);
        case 'category':
          return a.category.compareTo(b.category);
        case 'price':
          return a.price.compareTo(b.price);
        default:
          return 0;
      }
    });

    setState(() {
      _displayedItems = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced List')),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: _displayedItems.isEmpty && !_isLoading
                ? const Center(child: Text('No items found'))
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _displayedItems.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _displayedItems.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return _buildListItem(_displayedItems[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search items...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _filterQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() => _filterQuery = '');
                        _applyFilters();
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() => _filterQuery = value);
              _applyFilters();
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Sort by: '),
              const SizedBox(width: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'name', label: Text('Name')),
                  ButtonSegment(value: 'category', label: Text('Category')),
                  ButtonSegment(value: 'price', label: Text('Price')),
                ],
                selected: {_sortBy},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    _sortBy = newSelection.first;
                    _applyFilters();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(Item item, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text('${item.id}'),
        ),
        title: Text(item.name),
        subtitle: Text('${item.category} • \$${item.price}'),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
        ),
      ),
    );
  }
}

class Item {
  final int id;
  final String name;
  final String category;
  final String price;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });
}

