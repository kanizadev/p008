/// Basic Widgets Example
///
/// Demonstrates fundamental Flutter widgets that form the building blocks
/// of any Flutter application. This example showcases:
/// - Text widgets with different styles
/// - Various button types (ElevatedButton, TextButton, OutlinedButton, IconButton, FAB)
/// - Icons and Image widgets
/// - Input widgets: Switch, Checkbox, Radio buttons
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => BasicWidgetsExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating basic Flutter widgets.
///
/// This is a StatefulWidget because it manages interactive widget states
/// (switch, checkbox, radio button values).
class BasicWidgetsExample extends StatefulWidget {
  const BasicWidgetsExample({super.key});

  @override
  State<BasicWidgetsExample> createState() => _BasicWidgetsExampleState();
}

class _BasicWidgetsExampleState extends State<BasicWidgetsExample> {
  bool _switchValue = true;
  bool _checkboxValue = true;
  int _radioValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text Examples
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Text Widgets',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    const Text('Regular Text'),
                    Text(
                      'Bold Text',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Large Text',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'Colored Text',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Button Examples
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buttons',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Elevated Button'),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Outlined Button'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Text Button'),
                    ),
                    const SizedBox(height: 8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite),
                      tooltip: 'Favorite',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Icons
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Icons',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: const [
                        Icon(Icons.home, size: 32),
                        Icon(Icons.favorite, size: 32, color: Colors.red),
                        Icon(Icons.star, size: 32, color: Colors.amber),
                        Icon(Icons.settings, size: 32),
                        Icon(Icons.search, size: 32),
                        Icon(Icons.share, size: 32),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Images
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Images',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.image,
                        size: 48,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Placeholder for Image widget'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Switch & Checkbox
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Controls',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      title: const Text('Enable Notifications'),
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Accept Terms'),
                      value: _checkboxValue,
                      onChanged: (value) {
                        setState(() {
                          _checkboxValue = value ?? false;
                        });
                      },
                    ),
                    RadioGroup<int>(
                      groupValue: _radioValue,
                      onChanged: (value) {
                        setState(() {
                          _radioValue = value!;
                        });
                      },
                      child: Column(
                        children: [
                          RadioListTile<int>(
                            title: const Text('Option 1'),
                            value: 1,
                          ),
                          RadioListTile<int>(
                            title: const Text('Option 2'),
                            value: 2,
                          ),
                        ],
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
