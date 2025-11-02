/// Responsive Design Example
///
/// Demonstrates responsive UI design in Flutter.
/// This example showcases:
/// - MediaQuery: Accessing screen size, orientation, pixel ratio
/// - LayoutBuilder: Building layouts based on constraints
/// - OrientationBuilder: Adapting UI to orientation changes
/// - Breakpoints: Material Design 3 responsive breakpoints
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => ResponsiveDesignExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating responsive design patterns.
///
/// Shows how to create adaptive UIs that work on different screen sizes.
class ResponsiveDesignExample extends StatelessWidget {
  const ResponsiveDesignExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Design')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              context,
              'MediaQuery',
              'Screen size and orientation detection',
              Icons.straighten,
              _MediaQueryExample(),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'LayoutBuilder',
              'Responsive layout based on constraints',
              Icons.view_quilt,
              _LayoutBuilderExample(),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'OrientationBuilder',
              'Adaptive UI based on orientation',
              Icons.screen_rotation,
              _OrientationBuilderExample(),
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              'Breakpoints',
              'Material Design 3 breakpoints',
              Icons.desktop_windows,
              _BreakpointsExample(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget content,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }
}

class _MediaQueryExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textScaler = MediaQuery.of(context).textScaler;

    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Width', '${size.width.toStringAsFixed(0)} px'),
            _buildInfoRow('Height', '${size.height.toStringAsFixed(0)} px'),
            _buildInfoRow(
              'Orientation',
              orientation.toString().split('.').last,
            ),
            _buildInfoRow('Pixel Ratio', pixelRatio.toStringAsFixed(2)),
            _buildInfoRow('Text Scale', textScaler.scale(1).toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}

class _LayoutBuilderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                isWide ? 'Wide Layout' : 'Narrow Layout',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (isWide)
                Row(
                  children: [
                    Expanded(child: _buildBox('Column 1')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildBox('Column 2')),
                    const SizedBox(width: 8),
                    Expanded(child: _buildBox('Column 3')),
                  ],
                )
              else
                Column(
                  children: [
                    _buildBox('Row 1'),
                    const SizedBox(height: 8),
                    _buildBox('Row 2'),
                    const SizedBox(height: 8),
                    _buildBox('Row 3'),
                  ],
                ),
              const SizedBox(height: 16),
              Text('Max Width: ${constraints.maxWidth.toStringAsFixed(0)}'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBox(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(text)),
    );
  }
}

class _OrientationBuilderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(
                isPortrait ? Icons.phone_android : Icons.phone_android,
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                isPortrait ? 'Portrait Mode' : 'Landscape Mode',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: List.generate(
                  isPortrait ? 4 : 8,
                  (index) => Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text('${index + 1}')),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BreakpointsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String breakpoint;
    Color color;

    if (width < 600) {
      breakpoint = 'Mobile';
      color = Colors.blue;
    } else if (width < 840) {
      breakpoint = 'Tablet';
      color = Colors.green;
    } else if (width < 1200) {
      breakpoint = 'Desktop';
      color = Colors.orange;
    } else {
      breakpoint = 'Large Desktop';
      color = Colors.purple;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Icon(Icons.devices, size: 48, color: color),
          const SizedBox(height: 8),
          Text(
            breakpoint,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text('Width: ${width.toStringAsFixed(0)} px'),
        ],
      ),
    );
  }
}
