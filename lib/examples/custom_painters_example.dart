/// Custom Painters Example
///
/// Demonstrates custom painting and canvas operations in Flutter.
/// This example showcases:
/// - CustomPainter implementation
/// - Canvas drawing operations (paths, shapes, gradients)
/// - Advanced graphics rendering
/// - Animated custom painters
/// - Performance-optimized painting
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => CustomPaintersExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

/// Main widget demonstrating custom painting techniques.
///
/// Shows how to create custom graphics using the Canvas API.
class CustomPaintersExample extends StatefulWidget {
  const CustomPaintersExample({super.key});

  @override
  State<CustomPaintersExample> createState() => _CustomPaintersExampleState();
}

class _CustomPaintersExampleState extends State<CustomPaintersExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Painters')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return _buildSection(
                  'Animated Wave',
                  AnimatedWavePainter(animationValue: _controller.value),
                );
              },
            ),
            const SizedBox(height: 24),
            _buildSection('Geometric Patterns', const GeometricPainter()),
            const SizedBox(height: 24),
            _buildSection('Gradient Shapes', const GradientPainter()),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return _buildSection(
                  'Particle System',
                  ParticlePainter(_controller.value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, CustomPainter painter) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: CustomPaint(painter: painter, child: Container()),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated wave painter
class AnimatedWavePainter extends CustomPainter {
  final double animationValue;

  AnimatedWavePainter({this.animationValue = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final waveLength = size.width / 2.5;
    final amplitude = math.min(size.height * 0.15, 40.0);

    // Create filled wave path
    final path = Path();
    path.moveTo(0, centerY);

    // Use a finer step for smoother wave
    const step = 2.0;
    for (double x = 0; x <= size.width; x += step) {
      final y =
          centerY +
          amplitude * math.sin((x / waveLength + animationValue) * 2 * math.pi);
      path.lineTo(x, y);
    }

    // Ensure we reach the end
    final finalY =
        centerY +
        amplitude *
            math.sin((size.width / waveLength + animationValue) * 2 * math.pi);
    path.lineTo(size.width, finalY);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Draw filled wave with gradient
    final fillGradient = ui.Gradient.linear(
      Offset(0, centerY - amplitude),
      Offset(0, centerY + amplitude),
      [
        Colors.blue.withValues(alpha: 0.4),
        Colors.blue.withValues(alpha: 0.2),
        Colors.blue.withValues(alpha: 0.4),
      ],
      [0.0, 0.5, 1.0],
    );

    final fillPaint = Paint()
      ..shader = fillGradient
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Draw wave outline
    final outlinePath = Path();
    outlinePath.moveTo(0, centerY);

    for (double x = 0; x <= size.width; x += step) {
      final y =
          centerY +
          amplitude * math.sin((x / waveLength + animationValue) * 2 * math.pi);
      outlinePath.lineTo(x, y);
    }

    // Ensure we reach the end
    final outlineFinalY =
        centerY +
        amplitude *
            math.sin((size.width / waveLength + animationValue) * 2 * math.pi);
    outlinePath.lineTo(size.width, outlineFinalY);

    final strokePaint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(outlinePath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant AnimatedWavePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}

/// Geometric patterns painter
class GeometricPainter extends CustomPainter {
  const GeometricPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 3;

    // Draw concentric circles
    const circleCount = 5;
    for (int i = circleCount; i > 0; i--) {
      final circleRadius = maxRadius * (i / circleCount);
      final paint = Paint()
        ..color = Colors.primaries[(i - 1) % Colors.primaries.length]
            .withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      canvas.drawCircle(center, circleRadius, paint);
    }

    // Draw lines from center
    const lineCount = 12;
    final linePaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.6)
      ..strokeWidth = 1.5;

    for (int i = 0; i < lineCount; i++) {
      final angle = (i * 2 * math.pi) / lineCount;
      final endX = center.dx + maxRadius * math.cos(angle);
      final endY = center.dy + maxRadius * math.sin(angle);
      canvas.drawLine(center, Offset(endX, endY), linePaint);
    }

    // Draw center point
    final centerPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 4.0, centerPaint);
  }

  @override
  bool shouldRepaint(covariant GeometricPainter oldDelegate) => false;
}

/// Gradient shapes painter
class GradientPainter extends CustomPainter {
  const GradientPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Create gradient
    final gradient = ui.Gradient.linear(
      Offset(0, 0),
      Offset(size.width, size.height),
      [Colors.purple, Colors.blue, Colors.teal],
      [0.0, 0.5, 1.0],
    );

    final paint = Paint()..shader = gradient;

    // Draw rounded rectangle
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));
    canvas.drawRRect(rrect, paint);

    // Draw circle overlay
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 4;

    final circlePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, circlePaint);

    // Draw border
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant GradientPainter oldDelegate) => false;
}

/// Particle system painter
class ParticlePainter extends CustomPainter {
  final double animationValue;

  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    const particleCount = 60;
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2.5;

    // Create three orbital rings with different speeds and radii
    const rings = 3;
    const particlesPerRing = particleCount ~/ rings;

    for (int ring = 0; ring < rings; ring++) {
      final ringIndex = ring;
      final distanceFactor = [0.25, 0.55, 0.85][ringIndex];
      final distance = maxRadius * distanceFactor;
      final speedMultiplier = [
        1.0,
        1.5,
        2.0,
      ][ringIndex]; // Different speeds per ring

      for (int i = 0; i < particlesPerRing; i++) {
        final particleIndex = ring * particlesPerRing + i;

        // Calculate angle with different speeds for each ring
        final baseAngle = (i / particlesPerRing) * 2 * math.pi;
        final animatedAngle =
            baseAngle + animationValue * 2 * math.pi * speedMultiplier;

        final x = center.dx + distance * math.cos(animatedAngle);
        final y = center.dy + distance * math.sin(animatedAngle);

        // Calculate particle size and opacity based on ring
        final particleSize = [2.5, 4.0, 5.5][ringIndex];
        final opacity = [0.4, 0.65, 0.85][ringIndex];

        // Create glow effect for outer particles
        if (ringIndex == rings - 1) {
          final glowPaint = Paint()
            ..color = Colors.primaries[particleIndex % Colors.primaries.length]
                .withValues(alpha: opacity * 0.3)
            ..style = PaintingStyle.fill;
          canvas.drawCircle(Offset(x, y), particleSize * 1.8, glowPaint);
        }

        final paint = Paint()
          ..color = Colors.primaries[particleIndex % Colors.primaries.length]
              .withValues(alpha: opacity)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(Offset(x, y), particleSize, paint);

        // Add highlight for depth
        final highlightPaint = Paint()
          ..color = Colors.white.withValues(alpha: opacity * 0.5)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          Offset(x - particleSize * 0.3, y - particleSize * 0.3),
          particleSize * 0.4,
          highlightPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
