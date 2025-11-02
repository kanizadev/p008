import 'package:flutter/material.dart';

class DragDropExample extends StatefulWidget {
  const DragDropExample({super.key});

  @override
  State<DragDropExample> createState() => _DragDropExampleState();
}

class _DragDropExampleState extends State<DragDropExample> {
  final List<_DraggableItem> _items = [
    _DraggableItem(id: 1, color: Colors.red, label: 'Item 1'),
    _DraggableItem(id: 2, color: Colors.blue, label: 'Item 2'),
    _DraggableItem(id: 3, color: Colors.green, label: 'Item 3'),
    _DraggableItem(id: 4, color: Colors.orange, label: 'Item 4'),
  ];

  final List<_DraggableItem> _droppedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag & Drop'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInstructionCard(),
            const SizedBox(height: 24),
            _buildDraggableItems(),
            const SizedBox(height: 24),
            _buildDropZone(),
            const SizedBox(height: 24),
            _buildReorderableList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionCard() {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(height: 8),
            Text(
              'Drag items to the drop zone below',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableItems() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Draggable Items',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _items.map((item) {
                return Draggable<_DraggableItem>(
                  data: item,
                  feedback: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: item.color,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          item.label,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.drag_handle, color: Colors.grey),
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.drag_handle, color: Colors.white),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropZone() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Drop Zone', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            DragTarget<_DraggableItem>(
              onAcceptWithDetails: (details) {
                setState(() {
                  final item = details.data;
                  if (!_droppedItems.contains(item)) {
                    _droppedItems.add(item);
                  }
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: candidateData.isNotEmpty
                        ? Colors.green[100]
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: candidateData.isNotEmpty
                          ? Colors.green
                          : Colors.grey,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: _droppedItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload,
                                size: 48,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Drop items here',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          itemCount: _droppedItems.length,
                          itemBuilder: (context, index) {
                            final item = _droppedItems[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: item.color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  item.label,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
            if (_droppedItems.isNotEmpty) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _droppedItems.clear();
                  });
                },
                child: const Text('Clear Drop Zone'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildReorderableList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reorderable List',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = _droppedItems.removeAt(oldIndex);
                  _droppedItems.insert(newIndex, item);
                });
              },
              children: _droppedItems.map((item) {
                return ListTile(
                  key: ValueKey(item.id),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: item.color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.drag_handle, color: Colors.white),
                  ),
                  title: Text(item.label),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _droppedItems.remove(item);
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            if (_droppedItems.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Drop items above to see reorderable list',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DraggableItem {
  final int id;
  final Color color;
  final String label;

  _DraggableItem({required this.id, required this.color, required this.label});
}
