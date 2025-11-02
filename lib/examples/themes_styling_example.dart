/// Themes & Styling Example
///
/// Demonstrates theme management and styling in Flutter.
/// This example showcases:
/// - ThemeData: App-wide theming
/// - ColorScheme: Material 3 color schemes
/// - Text styles: Custom typography
/// - Button styles: Custom button appearances
/// - Card styles: Styled card widgets
/// - Material 3 components: Modern Material Design
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => ThemesStylingExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating theme and styling options.
///
/// Shows how to customize app appearance with themes and styles.
class ThemesStylingExample extends StatefulWidget {
  const ThemesStylingExample({super.key});

  @override
  State<ThemesStylingExample> createState() => _ThemesStylingExampleState();
}

class _ThemesStylingExampleState extends State<ThemesStylingExample> {
  ThemeMode _themeMode = ThemeMode.system;
  Color _selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _selectedColor),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _selectedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Themes & Styling'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildThemeSelector(context),
                const SizedBox(height: 24),
                _buildColorSelector(context),
                const SizedBox(height: 24),
                _buildTextStyles(context),
                const SizedBox(height: 24),
                _buildButtonStyles(context),
                const SizedBox(height: 24),
                _buildCardStyles(context),
                const SizedBox(height: 24),
                _buildMaterial3Examples(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme Mode', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.brightness_auto),
                ),
              ],
              selected: {_themeMode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                setState(() {
                  _themeMode = newSelection.first;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelector(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Color Scheme', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: colors.map((color) {
                final isSelected = _selectedColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextStyles(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Text Styles', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(
              'Display Large',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'Headline Medium',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text('Title Large', style: Theme.of(context).textTheme.titleLarge),
            Text('Body Large', style: Theme.of(context).textTheme.bodyLarge),
            Text('Body Small', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            Text(
              'Custom Styled Text',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonStyles(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Button Styles',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text('Elevated Button'),
            ),
            const SizedBox(height: 8),
            FilledButton(onPressed: () {}, child: const Text('Filled Button')),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 8),
            TextButton(onPressed: () {}, child: const Text('Text Button')),
            const SizedBox(height: 8),
            IconButton.filled(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardStyles(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Styles', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Colored Card'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Elevated Card'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Surface Variant Card'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterial3Examples(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Material 3 Components',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Tonal Button
            FilledButton.tonal(
              onPressed: () {},
              child: const Text('Tonal Button'),
            ),
            const SizedBox(height: 12),
            // Filled Icon Button
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.star),
              label: const Text('Filled Icon Button'),
            ),
            const SizedBox(height: 12),
            // Outlined Icon Button
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Outlined Icon Button'),
            ),
            const SizedBox(height: 12),
            // Segmented Button
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(
                  value: 1,
                  label: Text('One'),
                  icon: Icon(Icons.looks_one),
                ),
                ButtonSegment(
                  value: 2,
                  label: Text('Two'),
                  icon: Icon(Icons.looks_two),
                ),
                ButtonSegment(
                  value: 3,
                  label: Text('Three'),
                  icon: Icon(Icons.looks_3),
                ),
              ],
              selected: const {1},
              onSelectionChanged: (Set<int> newSelection) {
                // Handle selection change
              },
            ),
            const SizedBox(height: 16),
            // Filled Card
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filled Card (Material 3)',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This card uses primaryContainer color',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Outlined Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.12),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Outlined Card (Material 3)'),
              ),
            ),
            const SizedBox(height: 12),
            // Elevated Card
            Card(
              elevation: 2,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Elevated Card (Material 3)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
