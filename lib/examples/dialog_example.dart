/// Dialog Example
///
/// Demonstrates various dialog and bottom sheet implementations in Flutter.
/// This example showcases:
/// - AlertDialog: Simple alert messages
/// - SimpleDialog: Dialogs with multiple options
/// - ConfirmationDialog: Yes/No confirmation dialogs
/// - CustomDialog: Fully customized dialog design
/// - SnackBar: Temporary notification messages
/// - BottomSheet: Persistent bottom sheets
/// - ModalBottomSheet: Full-screen modal bottom sheets
/// - DatePicker and TimePicker: Date/time selection dialogs
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => DialogExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating different dialog types and bottom sheets.
///
/// Each section demonstrates a different dialog/bottom sheet variant
/// with interactive examples.
class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialogs & Snackbars')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            'Alert Dialog',
            'Show a simple alert dialog',
            Icons.warning,
            () => _showAlertDialog(context),
          ),
          _buildSection(
            context,
            'Simple Dialog',
            'Show a dialog with options',
            Icons.list,
            () => _showSimpleDialog(context),
          ),
          _buildSection(
            context,
            'Confirmation Dialog',
            'Ask for user confirmation',
            Icons.check_circle,
            () => _showConfirmationDialog(context),
          ),
          _buildSection(
            context,
            'Custom Dialog',
            'Show a custom styled dialog',
            Icons.design_services,
            () => _showCustomDialog(context),
          ),
          _buildSection(
            context,
            'Snackbar',
            'Show a snackbar message',
            Icons.message,
            () => _showSnackBar(context),
          ),
          _buildSection(
            context,
            'Bottom Sheet',
            'Show a bottom sheet',
            Icons.view_day,
            () => _showBottomSheet(context),
          ),
          _buildSection(
            context,
            'Modal Bottom Sheet',
            'Show a modal bottom sheet',
            Icons.view_agenda,
            () => _showModalBottomSheet(context),
          ),
          _buildSection(
            context,
            'Time Picker',
            'Show a time picker dialog',
            Icons.access_time,
            () => _showTimePicker(context),
          ),
          _buildSection(
            context,
            'Date Picker',
            'Show a date picker dialog',
            Icons.calendar_today,
            () => _showDatePicker(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert Dialog'),
        content: const Text('This is a simple alert dialog example.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSimpleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose an Option'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              navigator.pop();
              messenger.showSnackBar(
                const SnackBar(content: Text('Option 1 selected')),
              );
            },
            child: const Text('Option 1'),
          ),
          SimpleDialogOption(
            onPressed: () {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              navigator.pop();
              messenger.showSnackBar(
                const SnackBar(content: Text('Option 2 selected')),
              );
            },
            child: const Text('Option 2'),
          ),
          SimpleDialogOption(
            onPressed: () {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              navigator.pop();
              messenger.showSnackBar(
                const SnackBar(content: Text('Option 3 selected')),
              );
            },
            child: const Text('Option 3'),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Action'),
        content: const Text('Are you sure you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              navigator.pop();
              messenger.showSnackBar(
                const SnackBar(content: Text('Action cancelled')),
              );
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              navigator.pop();
              messenger.showSnackBar(
                const SnackBar(content: Text('Action confirmed!')),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.blue[400]!, Colors.purple[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.white, size: 60),
              const SizedBox(height: 16),
              const Text(
                'Custom Dialog',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This is a custom styled dialog with gradient background.',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('This is a snackbar message!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Action undone')));
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    // Use Builder to ensure we have the correct context with Scaffold
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Bottom Sheet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(
                Icons.share,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Share'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(
                Icons.copy,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Copy'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
              title: const Text('Delete'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Modal Bottom Sheet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Edit'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Add to Favorites'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected time: ${picked.format(context)}')),
        );
      }
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Selected date: ${picked.day}/${picked.month}/${picked.year}',
            ),
          ),
        );
      }
    }
  }
}
