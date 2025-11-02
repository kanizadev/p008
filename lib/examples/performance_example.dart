/// Performance Optimization Example
///
/// Demonstrates various performance optimization techniques in Flutter.
/// This example showcases:
/// - Const constructors for immutable widgets
/// - Proper use of keys for widget identity
/// - RepaintBoundary to isolate paint operations
/// - ListView.builder for efficient list rendering
/// - Selective rebuilds with extracted widgets
/// - ValueListenableBuilder for targeted updates
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => PerformanceExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating performance optimization techniques.
///
/// Shows how to optimize Flutter apps for better performance.
class PerformanceExample extends StatefulWidget {
  const PerformanceExample({super.key});

  @override
  State<PerformanceExample> createState() => _PerformanceExampleState();
}

class _PerformanceExampleState extends State<PerformanceExample> {
  int _counter = 0;
  bool _useConst = true;
  bool _useKeys = true;
  late final ValueNotifier<int> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Optimization'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPerformanceTip(
              context,
              '1. Use const constructors',
              'Mark widgets as const when values don\'t change',
              _constExample(),
            ),
            const SizedBox(height: 16),
            _buildPerformanceTip(
              context,
              '2. Use keys properly',
              'Keys help Flutter identify widgets in lists',
              _keysExample(),
            ),
            const SizedBox(height: 16),
            _buildPerformanceTip(
              context,
              '3. Avoid rebuilds with RepaintBoundary',
              'Isolate expensive paint operations',
              _repaintBoundaryExample(),
            ),
            const SizedBox(height: 16),
            _buildPerformanceTip(
              context,
              '4. Use ListView.builder',
              'Only builds visible items',
              _listViewBuilderExample(),
            ),
            const SizedBox(height: 16),
            _buildPerformanceTip(
              context,
              '5. Optimize rebuilds',
              'Use setState selectively and extract widgets',
              _optimizedRebuildExample(),
            ),
            const SizedBox(height: 16),
            _buildPerformanceTip(
              context,
              '6. Use ValueListenableBuilder',
              'Rebuild only specific parts of the tree',
              _valueListenableExample(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceTip(
    BuildContext context,
    String title,
    String description,
    Widget example,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            example,
          ],
        ),
      ),
    );
  }

  Widget _constExample() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _useConst = !_useConst;
            });
          },
          child: Text(
            _useConst ? 'Using const (Optimized)' : 'Not using const (Slower)',
          ),
        ),
        const SizedBox(height: 16),
        // These widgets won't rebuild when _useConst changes
        if (_useConst)
          const Row(
            children: [
              _ConstWidget(text: 'Widget 1'),
              SizedBox(width: 8),
              _ConstWidget(text: 'Widget 2'),
              SizedBox(width: 8),
              _ConstWidget(text: 'Widget 3'),
            ],
          )
        else
          Row(
            children: [
              _NonConstWidget(text: 'Widget 1'),
              const SizedBox(width: 8),
              _NonConstWidget(text: 'Widget 2'),
              const SizedBox(width: 8),
              _NonConstWidget(text: 'Widget 3'),
            ],
          ),
      ],
    );
  }

  Widget _keysExample() {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Use Keys'),
          value: _useKeys,
          onChanged: (value) {
            setState(() {
              _useKeys = value;
            });
          },
        ),
        const SizedBox(height: 16),
        if (_useKeys)
          const Row(
            children: [
              _KeyedWidget(key: ValueKey('item1'), color: Colors.red),
              SizedBox(width: 8),
              _KeyedWidget(key: ValueKey('item2'), color: Colors.blue),
              SizedBox(width: 8),
              _KeyedWidget(key: ValueKey('item3'), color: Colors.green),
            ],
          )
        else
          const Row(
            children: [
              _KeyedWidget(color: Colors.red),
              SizedBox(width: 8),
              _KeyedWidget(color: Colors.blue),
              SizedBox(width: 8),
              _KeyedWidget(color: Colors.green),
            ],
          ),
      ],
    );
  }

  Widget _repaintBoundaryExample() {
    return RepaintBoundary(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.pink, Colors.orange],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'This widget is isolated',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _listViewBuilderExample() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: 100,
        cacheExtent: 200, // Pre-render items outside viewport
        addAutomaticKeepAlives: false, // Don't keep state for off-screen items
        addRepaintBoundaries:
            true, // Add repaint boundaries for better performance
        itemBuilder: (context, index) {
          // Only builds visible items (lazy loading)
          return ListTile(
            key: ValueKey('item_$index'), // Key for efficient updates
            title: Text('Item $index'),
            leading: CircleAvatar(child: Text('$index')),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }

  Widget _optimizedRebuildExample() {
    return Column(
      children: [
        // Only this part rebuilds when counter changes
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter: '),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment'),
            ),
            // This widget is extracted as a const widget
            // It won't rebuild when counter changes, saving resources
            const _NonRebuildingWidget(),
          ],
        ),
        const SizedBox(height: 16),
        // This widget also won't rebuild - demonstrating selective rebuilds
        const _OptimizedSubWidget(),
      ],
    );
  }

  Widget _valueListenableExample() {
    return Column(
      children: [
        ValueListenableBuilder<int>(
          valueListenable: _valueNotifier,
          builder: (context, value, child) {
            // Only this part rebuilds, child widget is reused
            return Column(
              children: [
                Text(
                  'Value: $value',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child!, // Reused child widget
              ],
            );
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Only the value text rebuilds',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _valueNotifier.value++;
          },
          child: const Text('Increment Value'),
        ),
      ],
    );
  }
}

// Const widget example
class _ConstWidget extends StatelessWidget {
  final String text;

  const _ConstWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}

// Non-const widget example
class _NonConstWidget extends StatelessWidget {
  final String text;

  const _NonConstWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}

// Keyed widget example
class _KeyedWidget extends StatefulWidget {
  final Color color;

  const _KeyedWidget({super.key, required this.color});

  @override
  State<_KeyedWidget> createState() => _KeyedWidgetState();
}

class _KeyedWidgetState extends State<_KeyedWidget> {
  int _internalState = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _internalState++;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '$_internalState',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Widget that doesn't rebuild
class _NonRebuildingWidget extends StatelessWidget {
  const _NonRebuildingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Text(
            'Stable Widget\n(No rebuilds)',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Another optimized widget example
class _OptimizedSubWidget extends StatelessWidget {
  const _OptimizedSubWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline, color: Colors.blue),
          SizedBox(height: 4),
          Text(
            'Extract widgets to prevent\nunnecessary rebuilds',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
