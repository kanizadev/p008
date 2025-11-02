import 'package:flutter/material.dart';

class AccessibilityExample extends StatelessWidget {
  const AccessibilityExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSemanticExample(context),
            const SizedBox(height: 24),
            _buildTooltipExample(context),
            const SizedBox(height: 24),
            _buildExcludeSemanticsExample(context),
            const SizedBox(height: 24),
            _buildMergeSemanticsExample(context),
            const SizedBox(height: 24),
            _buildAccessibilityFeatures(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSemanticExample(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Semantic Widgets',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'This is a custom button with semantic label',
              button: true,
              enabled: true,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Semantic button pressed')),
                  );
                },
                child: const Text('Semantic Button'),
              ),
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'Custom semantic container',
              container: true,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('This container has semantic information'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTooltipExample(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tooltips', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                Tooltip(
                  message: 'This is a tooltip',
                  child: IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () {},
                  ),
                ),
                Tooltip(
                  message: 'Long press or hover for more info',
                  preferBelow: false,
                  child: IconButton(
                    icon: const Icon(Icons.help),
                    onPressed: () {},
                  ),
                ),
                Tooltip(
                  message: 'Custom styled tooltip',
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(color: Colors.white),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Hover me'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExcludeSemanticsExample(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exclude Semantics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'Button with decorative icon',
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: ExcludeSemantics(
                  child: Icon(Icons.star, color: Colors.amber),
                ),
                label: const Text('Favorite'),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'The star icon is excluded from semantics as it\'s decorative',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMergeSemanticsExample(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Merge Semantics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            MergeSemantics(
              child: Row(
                children: [
                  Semantics(
                    label: 'User name:',
                    child: const Text(
                      'Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Semantics(label: 'John Doe', child: const Text('John Doe')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'The merged semantics will read: "User name: John Doe"',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilityFeatures(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accessibility Features',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'Accessible card with all features',
              button: true,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.accessibility_new,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Accessible Item',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            Text(
                              'Tap to interact',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildAccessibilityChecklist(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilityChecklist(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accessibility Checklist:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ...[
          'Use Semantic widgets',
          'Provide meaningful labels',
          'Add tooltips for icons',
          'Ensure sufficient color contrast',
          'Support keyboard navigation',
          'Test with screen readers',
        ].map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(item)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
