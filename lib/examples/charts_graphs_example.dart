import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChartsGraphsExample extends StatelessWidget {
  const ChartsGraphsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts & Graphs'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBarChart(context),
            const SizedBox(height: 24),
            _buildLineChart(context),
            const SizedBox(height: 24),
            _buildPieChart(context),
            const SizedBox(height: 24),
            _buildProgressChart(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bar Chart', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: CustomPaint(
                painter: _BarChartPainter(),
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Line Chart', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: CustomPaint(
                painter: _LineChartPainter(),
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pie Chart', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: CustomPaint(
                painter: _PieChartPainter(),
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChart(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress Rings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProgressRing(context, 0.7, Colors.blue, '70%'),
                _buildProgressRing(context, 0.5, Colors.green, '50%'),
                _buildProgressRing(context, 0.9, Colors.orange, '90%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRing(
    BuildContext context,
    double progress,
    Color color,
    String label,
  ) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CustomPaint(
            painter: _ProgressRingPainter(progress: progress, color: color),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;

  _BarChartPainter()
    : data = const [0.3, 0.6, 0.8, 0.4, 0.9, 0.5, 0.7],
      colors = const [
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.purple,
        Colors.red,
        Colors.teal,
        Colors.pink,
      ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final barWidth = (size.width - 40) / data.length;
    final maxValue = data.reduce(math.max);

    // Draw grid lines
    paint.color = Colors.grey[300]!;
    paint.strokeWidth = 1;
    for (int i = 0; i <= 4; i++) {
      final y = size.height - 20 - (i * (size.height - 40) / 4);
      canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), paint);
    }

    // Draw bars
    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i] / maxValue) * (size.height - 40);
      final x = 20 + (i * barWidth);
      final y = size.height - 20 - barHeight;

      paint.color = colors[i];
      paint.style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + 5, y, barWidth - 10, barHeight),
          const Radius.circular(4),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BarChartPainter oldDelegate) => false;
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;

  _LineChartPainter() : data = const [0.2, 0.5, 0.3, 0.7, 0.6, 0.9, 0.8];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final maxValue = data.reduce(math.max);
    final pointSpacing = (size.width - 40) / (data.length - 1);

    // Draw area under curve
    final areaPath = Path();
    areaPath.moveTo(20, size.height - 20);

    for (int i = 0; i < data.length; i++) {
      final x = 20 + (i * pointSpacing);
      final y = size.height - 20 - (data[i] / maxValue * (size.height - 40));
      if (i == 0) {
        areaPath.lineTo(x, y);
      } else {
        areaPath.lineTo(x, y);
      }
    }

    areaPath.lineTo(size.width - 20, size.height - 20);
    areaPath.close();

    paint.style = PaintingStyle.fill;
    paint.color = Colors.blue.withValues(alpha: 0.2);
    canvas.drawPath(areaPath, paint);

    // Draw line
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.blue;
    paint.strokeWidth = 3;

    final linePath = Path();
    for (int i = 0; i < data.length; i++) {
      final x = 20 + (i * pointSpacing);
      final y = size.height - 20 - (data[i] / maxValue * (size.height - 40));
      if (i == 0) {
        linePath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
      }

      // Draw points
      canvas.drawCircle(Offset(x, y), 5, Paint()..color = Colors.blue);
    }

    canvas.drawPath(linePath, paint);
  }

  @override
  bool shouldRepaint(_LineChartPainter oldDelegate) => false;
}

class _PieChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;

  _PieChartPainter()
    : data = const [0.3, 0.25, 0.2, 0.15, 0.1],
      colors = const [
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.purple,
        Colors.red,
      ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 20;
    final paint = Paint()..style = PaintingStyle.fill;

    double startAngle = -math.pi / 2; // Start from top

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = data[i] * 2 * math.pi;
      paint.color = colors[i];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw outline
      paint.style = PaintingStyle.stroke;
      paint.color = Colors.white;
      paint.strokeWidth = 3;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      paint.style = PaintingStyle.fill;

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(_PieChartPainter oldDelegate) => false;
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color color;

  _ProgressRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 5;

    // Background circle
    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    // Percentage text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(progress * 100).toInt()}%',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(_ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
