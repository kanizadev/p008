/// State Management Example
///
/// Demonstrates basic state management techniques in Flutter.
/// This example showcases:
/// - setState: Basic state updates for StatefulWidget
/// - Form state: Managing form input state
/// - Interactive widgets: Sliders, switches with state
/// - ValueNotifier: Reactive state management
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => StateManagementExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating state management patterns in Flutter.
///
/// Shows various techniques for managing and updating widget state.
class StateManagementExample extends StatefulWidget {
  const StateManagementExample({super.key});

  @override
  State<StateManagementExample> createState() => _StateManagementExampleState();
}

class _StateManagementExampleState extends State<StateManagementExample> {
  int _counter = 0;
  String _selectedColor = 'Blue';
  bool _isEnabled = true;
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('State Management Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Counter Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Counter Example (setState)',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _counter--;
                            });
                          },
                          icon: const Icon(Icons.remove),
                          label: const Text('Decrement'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _counter++;
                            });
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Increment'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Color Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Radio Selection (setState)',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    RadioGroup<String>(
                      groupValue: _selectedColor,
                      onChanged: (value) {
                        setState(() {
                          _selectedColor = value!;
                        });
                      },
                      child: Column(
                        children: ['Blue', 'Green', 'Red', 'Purple'].map((
                          color,
                        ) {
                          return RadioListTile<String>(
                            title: Text(color),
                            value: color,
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _getColorFromString(_selectedColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Selected: $_selectedColor',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Toggle Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Toggle Example (setState)',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Enable Feature'),
                      subtitle: Text(_isEnabled ? 'Enabled' : 'Disabled'),
                      value: _isEnabled,
                      onChanged: (value) {
                        setState(() {
                          _isEnabled = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _isEnabled
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Button is enabled!'),
                                ),
                              );
                            }
                          : null,
                      child: const Text('Click Me'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Slider Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slider Example (setState)',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text('Value: ${_sliderValue.toStringAsFixed(2)}'),
                    Slider(
                      value: _sliderValue,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: _sliderValue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Opacity: ${(_sliderValue * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Form Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Form State Management',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    const _FormExample(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case 'Blue':
        return Colors.blue;
      case 'Green':
        return Colors.green;
      case 'Red':
        return Colors.red;
      case 'Purple':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

class _FormExample extends StatefulWidget {
  const _FormExample();

  @override
  State<_FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<_FormExample> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Form submitted!\nName: ${_nameController.text}\nEmail: ${_emailController.text}',
                    ),
                  ),
                );
              }
            },
            child: const Text('Submit Form'),
          ),
        ],
      ),
    );
  }
}
