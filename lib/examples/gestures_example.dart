import 'package:flutter/material.dart';
import 'dart:math' as math;

class GesturesExample extends StatefulWidget {
  const GesturesExample({super.key});

  @override
  State<GesturesExample> createState() => _GesturesExampleState();
}

class _GesturesExampleState extends State<GesturesExample> {
  double _scale = 1.0;
  double _rotation = 0.0;
  Offset _position = Offset.zero;
  String _gestureStatus = 'Tap, drag, or scale';
  int _tapCount = 0;
  Offset _panPosition = Offset.zero;
  double _longPressScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestures & Interactions'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTapGesture(),
            const SizedBox(height: 24),
            _buildDoubleTapGesture(),
            const SizedBox(height: 24),
            _buildLongPressGesture(),
            const SizedBox(height: 24),
            _buildPanGesture(),
            const SizedBox(height: 24),
            _buildScaleGesture(),
            const SizedBox(height: 24),
            _buildCombinedGesture(),
          ],
        ),
      ),
    );
  }

  Widget _buildTapGesture() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tap Gesture', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _tapCount++;
                    _gestureStatus = 'Tapped $_tapCount times';
                  });
                },
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Tap Me!',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(child: Text(_gestureStatus)),
          ],
        ),
      ),
    );
  }

  Widget _buildDoubleTapGesture() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Double Tap Gesture',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onDoubleTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Double tapped!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Double Tap Me!',
                      style: TextStyle(color: Colors.white, fontSize: 20),
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

  Widget _buildLongPressGesture() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Long Press Gesture',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onLongPress: () {
                  setState(() {
                    _longPressScale = _longPressScale == 1.0 ? 1.5 : 1.0;
                  });
                },
                child: AnimatedScale(
                  scale: _longPressScale,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'Long Press',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
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

  Widget _buildPanGesture() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pan Gesture (Drag)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Positioned(
                    left: _panPosition.dx,
                    top: _panPosition.dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _panPosition += details.delta;
                          // Constrain to bounds
                          _panPosition = Offset(
                            _panPosition.dx.clamp(0.0, 250.0),
                            _panPosition.dy.clamp(0.0, 150.0),
                          );
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.drag_handle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _panPosition = Offset.zero;
                  });
                },
                child: const Text('Reset Position'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScaleGesture() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scale Gesture (Pinch)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onScaleUpdate: (details) {
                  setState(() {
                    _scale = (_scale * details.scale).clamp(0.5, 3.0);
                    _rotation += details.rotation;
                  });
                },
                onScaleEnd: (details) {
                  setState(() {
                    _scale = _scale.clamp(0.5, 3.0);
                  });
                },
                child: Transform.scale(
                  scale: _scale,
                  child: Transform.rotate(
                    angle: _rotation,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.pink],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.zoom_in,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(child: Text('Scale: ${_scale.toStringAsFixed(2)}x')),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _scale = 1.0;
                    _rotation = 0.0;
                  });
                },
                child: const Text('Reset'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedGesture() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Combined Gestures',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _position = Offset(
                      math.Random().nextDouble() * 200,
                      math.Random().nextDouble() * 200,
                    );
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    _position += details.delta;
                    _position = Offset(
                      _position.dx.clamp(0.0, 250.0),
                      _position.dy.clamp(0.0, 250.0),
                    );
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    _position = Offset.zero;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.touch_app, size: 48, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              'Tap to move\nDrag to reposition\nDouble tap to reset',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: _position.dx,
                      top: _position.dy,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.blue],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withValues(alpha: 0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.star, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
