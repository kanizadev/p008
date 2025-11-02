/// Layout Example
///
/// Demonstrates various layout widgets in Flutter for organizing UI elements.
/// This example showcases:
/// - Row and Column: Linear layouts (horizontal and vertical)
/// - Stack: Overlaying widgets on top of each other
/// - Wrap: Flexible wrapping layout
/// - Container: Versatile container with styling options
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => LayoutExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating different layout widgets.
///
/// Uses TabBarView to organize different layout examples into tabs.
class LayoutExample extends StatelessWidget {
  const LayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Layout Examples'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Row/Column'),
              Tab(text: 'Stack'),
              Tab(text: 'Wrap'),
              Tab(text: 'Container'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Builder(builder: (context) => _buildRowColumn(context)),
            _buildStack(),
            Builder(builder: (context) => _buildWrap(context)),
            Builder(builder: (context) => _buildContainer(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildRowColumn(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Row Example', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColoredBox(Colors.red, '1'),
              _buildColoredBox(Colors.green, '2'),
              _buildColoredBox(Colors.blue, '3'),
            ],
          ),
          const SizedBox(height: 24),
          Text('Column Example', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildColoredBox(Colors.red, '1'),
                    const SizedBox(height: 8),
                    _buildColoredBox(Colors.green, '2'),
                    const SizedBox(height: 8),
                    _buildColoredBox(Colors.blue, '3'),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildColoredBox(Colors.orange, 'A'),
                    const SizedBox(height: 8),
                    _buildColoredBox(Colors.purple, 'B'),
                    const SizedBox(height: 8),
                    _buildColoredBox(Colors.teal, 'C'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStack() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 50),
          ),
        ],
      ),
    );
  }

  Widget _buildWrap(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Wrap Example', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChip(context, 'Flutter'),
              _buildChip(context, 'Dart'),
              _buildChip(context, 'Material Design'),
              _buildChip(context, 'Widgets'),
              _buildChip(context, 'State Management'),
              _buildChip(context, 'Animations'),
              _buildChip(context, 'Navigation'),
              _buildChip(context, 'Forms'),
              _buildChip(context, 'Lists'),
              _buildChip(context, 'Layouts'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Container Examples',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Rounded Container',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Gradient Container',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Container with Shadow',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColoredBox(Color color, String label) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return Chip(
      label: Text(label),
      avatar: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          label[0].toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
