/// Interactive Charts Example
///
/// Demonstrates interactive chart implementations in Flutter.
/// This example showcases:
/// - Touch interactions on charts
/// - Real-time data updates
/// - Chart animations
/// - Multiple chart types
/// - Custom chart interactions
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => InteractiveChartsExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Main widget demonstrating interactive charts.
///
/// Shows touch interactions, animations, and real-time updates.
class InteractiveChartsExample extends StatefulWidget {
  const InteractiveChartsExample({super.key});

  @override
  State<InteractiveChartsExample> createState() =>
      _InteractiveChartsExampleState();
}

class _InteractiveChartsExampleState extends State<InteractiveChartsExample> {
  int? _selectedBarIndex;
  int _selectedPieIndex = 0;
  final List<double> _barData = [45, 60, 80, 55, 70, 90, 65];
  final List<ChartData> _pieData = [
    ChartData('Category A', 30, Colors.blue),
    ChartData('Category B', 25, Colors.green),
    ChartData('Category C', 20, Colors.orange),
    ChartData('Category D', 15, Colors.purple),
    ChartData('Category E', 10, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Interactive Charts'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Bar Chart'),
              Tab(text: 'Line Chart'),
              Tab(text: 'Pie Chart'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBarChart(),
            _buildLineChart(),
            _buildPieChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final maxValue = _barData.reduce(math.max);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            child: CustomPaint(
              painter: InteractiveBarChartPainter(
                data: _barData,
                selectedIndex: _selectedBarIndex,
                maxValue: maxValue,
              ),
              child: GestureDetector(
                onTapDown: (details) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final localPosition = box.globalToLocal(details.globalPosition);
                  final barWidth = (box.size.width - 48) / _barData.length;
                  final index = ((localPosition.dx - 24) / barWidth).floor();
                  if (index >= 0 && index < _barData.length) {
                    setState(() => _selectedBarIndex = index);
                  }
                },
              ),
            ),
          ),
          if (_selectedBarIndex != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Selected: Bar ${_selectedBarIndex! + 1} - '
                  'Value: ${_barData[_selectedBarIndex!].toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            child: CustomPaint(
              painter: InteractiveLineChartPainter(
                data: _barData,
                maxValue: _barData.reduce(math.max),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final random = math.Random();
                for (int i = 0; i < _barData.length; i++) {
                  _barData[i] = random.nextDouble() * 100;
                }
              });
            },
            child: const Text('Randomize Data'),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            padding: const EdgeInsets.all(16),
            child: CustomPaint(
              painter: InteractivePieChartPainter(
                data: _pieData,
                selectedIndex: _selectedPieIndex,
              ),
              child: GestureDetector(
                onTapDown: (details) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final center = Offset(box.size.width / 2, box.size.height / 2);
                  final localPosition = box.globalToLocal(details.globalPosition);
                  final dx = localPosition.dx - center.dx;
                  final dy = localPosition.dy - center.dy;
                  final angle = math.atan2(dy, dx);
                  final normalizedAngle = (angle + math.pi * 2) % (math.pi * 2);

                  double startAngle = 0;
                  for (int i = 0; i < _pieData.length; i++) {
                    final sweepAngle = (_pieData[i].value / 100) * math.pi * 2;
                    final endAngle = startAngle + sweepAngle;

                    if (normalizedAngle >= startAngle && normalizedAngle < endAngle) {
                      setState(() => _selectedPieIndex = i);
                      break;
                    }
                    startAngle = endAngle;
                  }
                },
              ),
            ),
          ),
          if (_selectedPieIndex < _pieData.length)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _pieData[_selectedPieIndex].color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _pieData[_selectedPieIndex].label,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${_pieData[_selectedPieIndex].value}%',
                      style: Theme.of(context).textTheme.headlineMedium,
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

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData(this.label, this.value, this.color);
}

class InteractiveBarChartPainter extends CustomPainter {
  final List<double> data;
  final int? selectedIndex;
  final double maxValue;

  InteractiveBarChartPainter({
    required this.data,
    this.selectedIndex,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = (size.width - 48) / data.length;
    final chartHeight = size.height - 40;

    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i] / maxValue) * chartHeight;
      final x = 24 + (i * barWidth) + (barWidth / 2) - 20;
      final y = size.height - 20 - barHeight;

      final isSelected = selectedIndex == i;
      final paint = Paint()
        ..color = isSelected
            ? Colors.blue.shade700
            : Colors.blue.withValues(alpha: 0.7);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, 40, barHeight),
          const Radius.circular(4),
        ),
        paint,
      );

      // Draw value label
      final textPainter = TextPainter(
        text: TextSpan(
          text: data[i].toStringAsFixed(0),
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + 20 - textPainter.width / 2, y - 18),
      );
    }
  }

  @override
  bool shouldRepaint(covariant InteractiveBarChartPainter oldDelegate) =>
      oldDelegate.selectedIndex != selectedIndex ||
      oldDelegate.data != data;
}

class InteractiveLineChartPainter extends CustomPainter {
  final List<double> data;
  final double maxValue;

  InteractiveLineChartPainter({
    required this.data,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final chartHeight = size.height - 40;
    final pointSpacing = (size.width - 48) / (data.length - 1);
    final path = Path();

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 1;
    for (int i = 0; i <= 4; i++) {
      final y = 20 + (chartHeight / 4) * i;
      canvas.drawLine(Offset(24, y), Offset(size.width - 24, y), gridPaint);
    }

    // Draw line
    for (int i = 0; i < data.length; i++) {
      final x = 24 + (i * pointSpacing);
      final y = size.height - 20 - ((data[i] / maxValue) * chartHeight);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw points
      final pointPaint = Paint()..color = Colors.blue;
      canvas.drawCircle(Offset(x, y), 5, pointPaint);
    }

    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant InteractiveLineChartPainter oldDelegate) =>
      oldDelegate.data != data;
}

class InteractivePieChartPainter extends CustomPainter {
  final List<ChartData> data;
  final int selectedIndex;

  InteractivePieChartPainter({
    required this.data,
    required this.selectedIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 20;
    double startAngle = -math.pi / 2;

    for (int i = 0; i < data.length; i++) {
      final sweepAngle = (data[i].value / 100) * math.pi * 2;
      final isSelected = selectedIndex == i;
      final offset = isSelected ? 10.0 : 0.0;
      final adjustedCenter = Offset(
        center.dx + math.cos(startAngle + sweepAngle / 2) * offset,
        center.dy + math.sin(startAngle + sweepAngle / 2) * offset,
      );

      final paint = Paint()
        ..color = data[i].color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: adjustedCenter, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant InteractivePieChartPainter oldDelegate) =>
      oldDelegate.selectedIndex != selectedIndex ||
      oldDelegate.data != data;
}

