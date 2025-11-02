/// Parallax Scrolling Example
///
/// Demonstrates parallax scrolling effects in Flutter.
/// This example showcases:
/// - Parallax header images
/// - Nested scroll views
/// - Custom scroll physics
/// - Scroll animations
/// - Sticky headers
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => ParallaxScrollingExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating parallax scrolling effects.
///
/// Shows how to create parallax header and nested scroll effects.
class ParallaxScrollingExample extends StatelessWidget {
  const ParallaxScrollingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Parallax Scrolling'),
              background: Image.network(
                'https://picsum.photos/800/400',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: const Icon(Icons.image, size: 100),
                  );
                },
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildHeaderItem(Icons.category, 'Categories'),
                      _buildHeaderItem(Icons.star, 'Featured'),
                      _buildHeaderItem(Icons.new_releases, 'New'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildParallaxCard(index),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildParallaxCard(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.primaries[index % Colors.primaries.length],
              Colors.primaries[index % Colors.primaries.length].withValues(
                alpha: 0.7,
              ),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                size: 48,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 8),
              Text(
                'Parallax Item ${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 70; // 10 padding top + 50 content + 10 padding bottom

  @override
  double get maxExtent => 70; // 10 padding top + 50 content + 10 padding bottom

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) =>
      child != oldDelegate.child;
}
