/// Stream State Management Example
///
/// Demonstrates stream-based state management in Flutter.
/// This example showcases:
/// - StreamController and StreamBuilder
/// - Real-time data updates
/// - Multiple streams composition
/// - Stream error handling
/// - Stream transformations
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => StreamStateManagementExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

/// Main widget demonstrating stream-based state management.
///
/// Shows real-time updates using streams.
class StreamStateManagementExample extends StatefulWidget {
  const StreamStateManagementExample({super.key});

  @override
  State<StreamStateManagementExample> createState() =>
      _StreamStateManagementExampleState();
}

class _StreamStateManagementExampleState
    extends State<StreamStateManagementExample> {
  final StreamController<int> _counterController =
      StreamController<int>.broadcast();
  final StreamController<String> _messageController =
      StreamController<String>.broadcast();
  final StreamController<double> _temperatureController =
      StreamController<double>.broadcast();
  Timer? _temperatureTimer;

  @override
  void initState() {
    super.initState();
    _setupStreams();
    _startTemperatureUpdates();
  }

  void _setupStreams() {
    // Note: With broadcast streams, StreamBuilder handles all updates
    // We don't need to listen manually anymore since StreamBuilder
    // will listen directly to the stream
  }

  void _startTemperatureUpdates() {
    _temperatureTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final random = math.Random();
      final newTemp = 15.0 + random.nextDouble() * 15.0;
      _temperatureController.add(newTemp);
    });
  }

  @override
  void dispose() {
    _temperatureTimer?.cancel();
    _counterController.close();
    _messageController.close();
    _temperatureController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stream State Management')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCounterExample(),
            const SizedBox(height: 24),
            _buildMessageExample(),
            const SizedBox(height: 24),
            _buildTemperatureExample(),
            const SizedBox(height: 24),
            _buildCombinedStreamExample(),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Counter Stream',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            StreamBuilder<int>(
              stream: _counterController.stream,
              initialData: 0,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Text(
                      '${snapshot.data ?? 0}',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            final currentValue = snapshot.data ?? 0;
                            _counterController.add(currentValue - 1);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          onPressed: () {
                            final currentValue = snapshot.data ?? 0;
                            _counterController.add(currentValue + 1);
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Message Stream',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            StreamBuilder<String>(
              stream: _messageController.stream,
              initialData: 'No messages yet',
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Text(
                      snapshot.data ?? 'No messages yet',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              _messageController.add('Hello World!'),
                          child: const Text('Send Hello'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              _messageController.add('Flutter is awesome!'),
                          child: const Text('Send Message'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              _messageController.add('Streams are powerful!'),
                          child: const Text('Send Info'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperatureExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Temperature Stream',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            StreamBuilder<double>(
              stream: _temperatureController.stream,
              initialData: 20.0,
              builder: (context, snapshot) {
                final temp = snapshot.data ?? 20.0;
                final color = temp < 20
                    ? Colors.blue
                    : temp > 25
                        ? Colors.red
                        : Colors.green;

                return Column(
                  children: [
                    Text(
                      '${temp.toStringAsFixed(1)}°C',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      temp < 20
                          ? 'Cold'
                          : temp > 25
                              ? 'Hot'
                              : 'Normal',
                      style: TextStyle(
                        fontSize: 18,
                        color: color,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedStreamExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Combined Stream',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder<int>(
                  stream: _counterController.stream,
                  initialData: 0,
                  builder: (context, counterSnapshot) {
                    return Column(
                      children: [
                        const Text('Counter'),
                        Text(
                          '${counterSnapshot.data ?? 0}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<double>(
                  stream: _temperatureController.stream,
                  initialData: 20.0,
                  builder: (context, tempSnapshot) {
                    return Column(
                      children: [
                        const Text('Temperature'),
                        Text(
                          '${(tempSnapshot.data ?? 20.0).toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

