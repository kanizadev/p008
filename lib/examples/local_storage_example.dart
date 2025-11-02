/// Local Storage Example
///
/// Demonstrates local data persistence in Flutter.
/// This example showcases:
/// - Save data: Storing key-value pairs
/// - Load data: Retrieving stored values
/// - Delete data: Removing stored values
/// - Clear all: Clearing all stored data
///
/// Note: This uses in-memory storage for demonstration. In a real app,
/// you would use packages like `shared_preferences` or `sqflite`.
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => LocalStorageExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';
// Note: In a real implementation, you would use the shared_preferences package
// import 'package:shared_preferences/shared_preferences.dart';

/// Main widget demonstrating local storage operations.
///
/// Shows how to save, load, and delete data locally.
class LocalStorageExample extends StatefulWidget {
  const LocalStorageExample({super.key});

  @override
  State<LocalStorageExample> createState() => _LocalStorageExampleState();
}

class _LocalStorageExampleState extends State<LocalStorageExample> {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  String _storedValue = '';
  String _error = '';

  // In-memory storage for demo purposes
  final Map<String, String> _storage = {};

  @override
  void initState() {
    super.initState();
    _loadValue('example_key');
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  Future<void> _saveValue() async {
    if (_keyController.text.isEmpty || _valueController.text.isEmpty) {
      setState(() {
        _error = 'Please enter both key and value';
      });
      return;
    }

    try {
      // In a real implementation:
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString(_keyController.text, _valueController.text);

      // Demo implementation using in-memory storage
      _storage[_keyController.text] = _valueController.text;

      setState(() {
        _error = '';
        _storedValue = '';
      });
      _loadValue(_keyController.text);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Value saved successfully!')),
      );
    } catch (e) {
      setState(() {
        _error = 'Error saving: $e';
      });
    }
  }

  Future<void> _loadValue(String key) async {
    try {
      // In a real implementation:
      // final prefs = await SharedPreferences.getInstance();
      // final value = prefs.getString(key);

      // Demo implementation
      final value = _storage[key];

      setState(() {
        _storedValue = value ?? 'No value found';
        _error = '';
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading: $e';
      });
    }
  }

  Future<void> _deleteValue(String key) async {
    try {
      // In a real implementation:
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.remove(key);

      // Demo implementation
      _storage.remove(key);

      setState(() {
        _storedValue = '';
        _error = '';
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Value deleted successfully!')),
      );
    } catch (e) {
      setState(() {
        _error = 'Error deleting: $e';
      });
    }
  }

  Future<void> _clearAll() async {
    try {
      // In a real implementation:
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.clear();

      // Demo implementation
      _storage.clear();

      setState(() {
        _storedValue = '';
        _error = '';
      });

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All data cleared!')));
    } catch (e) {
      setState(() {
        _error = 'Error clearing: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Storage')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Save Data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _keyController,
                      decoration: const InputDecoration(
                        labelText: 'Key',
                        hintText: 'Enter key',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _valueController,
                      decoration: const InputDecoration(
                        labelText: 'Value',
                        hintText: 'Enter value',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _saveValue,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stored Value',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(_storedValue, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _loadValue('example_key'),
                            child: const Text('Load'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _deleteValue('example_key'),
                            child: const Text('Delete'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_error.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                color: Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _error,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: _clearAll,
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Clear All Data'),
            ),
          ],
        ),
      ),
    );
  }
}
