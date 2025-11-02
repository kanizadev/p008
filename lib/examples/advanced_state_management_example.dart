/// Advanced State Management Example
///
/// Demonstrates advanced state management patterns in Flutter.
/// This example showcases:
/// - ValueNotifier with ValueListenableBuilder
/// - ChangeNotifier pattern
/// - State composition and lifting
/// - Provider-like pattern implementation
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => AdvancedStateManagementExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating advanced state management patterns.
///
/// Shows how to manage complex state with multiple notifiers and listeners.
class AdvancedStateManagementExample extends StatefulWidget {
  const AdvancedStateManagementExample({super.key});

  @override
  State<AdvancedStateManagementExample> createState() =>
      _AdvancedStateManagementExampleState();
}

class _AdvancedStateManagementExampleState
    extends State<AdvancedStateManagementExample> {
  final CounterNotifier _counter = CounterNotifier(0);
  final TodoNotifier _todos = TodoNotifier();

  @override
  void dispose() {
    _counter.dispose();
    _todos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced State Management')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCounterExample(),
            const SizedBox(height: 24),
            _buildTodoExample(),
            const SizedBox(height: 24),
            _buildMultiNotifierExample(),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ValueNotifier Pattern',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<int>(
              valueListenable: _counter,
              builder: (context, count, child) {
                return Column(
                  children: [
                    Text(
                      'Count: $count',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => _counter.decrement(),
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          onPressed: () => _counter.increment(),
                          icon: const Icon(Icons.add),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          onPressed: () => _counter.reset(),
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ChangeNotifier Pattern',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: _todos,
              builder: (context, child) {
                return Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter todo',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _todos.addTodo(value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    if (_todos.todos.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'No todos yet. Add one above!',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    else
                      ..._todos.todos.map(
                        (todo) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(todo.title),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _todos.removeTodo(todo.id),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiNotifierExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Composed State',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: Listenable.merge([_counter, _todos]),
              builder: (context, child) {
                final totalItems = _todos.todos.length;
                final counterValue = _counter.value;
                return Column(
                  children: [
                    Text(
                      'Total: ${counterValue + totalItems}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Counter: $counterValue + Todos: $totalItems',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Counter notifier using ValueNotifier
class CounterNotifier extends ValueNotifier<int> {
  CounterNotifier(super.value);

  void increment() => value++;
  void decrement() => value--;
  void reset() => value = 0;
}

/// Todo model
class Todo {
  final String id;
  final String title;

  Todo({required this.id, required this.title});
}

/// Todo notifier using ChangeNotifier
class TodoNotifier extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(String title) {
    _todos.add(
      Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title),
    );
    notifyListeners();
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
