/// Custom Widgets Example
///
/// Demonstrates custom widget creation in Flutter.
/// This example showcases:
/// - Custom progress bars
/// - Custom painting with charts
/// - Custom gradient buttons
/// - Custom shapes (star, hexagon, heart)
/// - Custom card widgets
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => CustomWidgetsExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Main widget demonstrating custom widget creation.
///
/// Shows how to create reusable custom widgets in Flutter.
class CustomWidgetsExample extends StatefulWidget {
  const CustomWidgetsExample({super.key});

  @override
  State<CustomWidgetsExample> createState() => _CustomWidgetsExampleState();
}

class _CustomWidgetsExampleState extends State<CustomWidgetsExample> {
  double _progress = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Widgets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCustomProgressBar(),
            const SizedBox(height: 24),
            _buildCustomPaintExample(),
            const SizedBox(height: 24),
            _buildCustomButton(),
            const SizedBox(height: 24),
            _buildGradientCard(),
            const SizedBox(height: 24),
            _buildCustomShape(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomProgressBar() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Progress Bar',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            CustomProgressBar(
              progress: _progress,
              backgroundColor: Colors.grey[300]!,
              progressColor: Colors.blue,
              height: 20,
            ),
            const SizedBox(height: 16),
            Slider(
              value: _progress,
              onChanged: (value) {
                setState(() {
                  _progress = value;
                });
              },
            ),
            Text('Progress: ${(_progress * 100).toStringAsFixed(0)}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomPaintExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Paint - Chart',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: CustomPaint(painter: _ChartPainter(), child: Container()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Button with Gradient',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Center(
              child: _CustomGradientButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Custom button pressed!')),
                  );
                },
                text: 'Press Me',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientCard() {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.white, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Gradient Card',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Custom styled widget with gradient background',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomShape() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Shapes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomPaint(size: const Size(80, 80), painter: _StarPainter()),
                CustomPaint(
                  size: const Size(80, 80),
                  painter: _HexagonPainter(),
                ),
                CustomPaint(size: const Size(80, 80), painter: _HeartPainter()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Progress Bar Widget
class CustomProgressBar extends StatelessWidget {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double height;

  const CustomProgressBar({
    super.key,
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Stack(
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
          FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [progressColor, progressColor.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(height / 2),
                boxShadow: [
                  BoxShadow(
                    color: progressColor.withValues(alpha: 0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Chart Painter
class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final data = [0.2, 0.5, 0.7, 0.4, 0.9, 0.6, 0.3];
    final barWidth = size.width / data.length;
    final maxValue = data.reduce((a, b) => a > b ? a : b);

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..strokeWidth = 1.0;
    for (int i = 0; i <= 4; i++) {
      final y = size.height - (i * size.height / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw bars with gradient
    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i] / maxValue) * size.height;
      final x = i * barWidth;
      final y = size.height - barHeight;

      final barRect = Rect.fromLTWH(x + 5, y, barWidth - 10, barHeight);

      // Create gradient for each bar
      final gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.primaries[i % Colors.primaries.length],
          Colors.primaries[i % Colors.primaries.length].withValues(alpha: 0.7),
        ],
      );

      final paint = Paint()
        ..shader = gradient.createShader(barRect)
        ..style = PaintingStyle.fill;

      // Draw rounded rectangle
      canvas.drawRRect(
        RRect.fromRectAndRadius(barRect, const Radius.circular(4)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ChartPainter oldDelegate) => false;
}

// Custom Gradient Button
class _CustomGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const _CustomGradientButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.pink, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withValues(alpha: 0.5),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Star Painter
class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.5;

    for (int i = 0; i < 5; i++) {
      final angle = (i * 4 * math.pi / 5) - math.pi / 2;
      final x = center.dx + math.cos(angle) * outerRadius;
      final y = center.dy + math.sin(angle) * outerRadius;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      final innerAngle = angle + (2 * math.pi / 5);
      final innerX = center.dx + math.cos(innerAngle) * innerRadius;
      final innerY = center.dy + math.sin(innerAngle) * innerRadius;
      path.lineTo(innerX, innerY);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_StarPainter oldDelegate) => false;
}

// Hexagon Painter
class _HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < 6; i++) {
      final angle = (i * math.pi / 3) - math.pi / 6;
      final x = center.dx + math.cos(angle) * radius;
      final y = center.dy + math.sin(angle) * radius;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HexagonPainter oldDelegate) => false;
}

// Heart Painter
class _HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final path = Path();

    path.moveTo(center.dx, center.dy + size.height / 4);
    path.cubicTo(
      center.dx - size.width / 3,
      center.dy - size.height / 4,
      center.dx - size.width / 2,
      center.dy - size.height / 2,
      center.dx,
      center.dy - size.height / 3,
    );
    path.cubicTo(
      center.dx + size.width / 2,
      center.dy - size.height / 2,
      center.dx + size.width / 3,
      center.dy - size.height / 4,
      center.dx,
      center.dy + size.height / 4,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HeartPainter oldDelegate) => false;
}
