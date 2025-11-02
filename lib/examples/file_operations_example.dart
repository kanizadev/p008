/// File Operations Example
///
/// Demonstrates file read and write operations in Flutter.
/// This example showcases:
/// - Save files: Writing content to files
/// - Read files: Reading file content
/// - Delete files: Removing files
/// - File info: Displaying file path and size
/// - Error handling: Managing file operation errors
///
/// Note: This uses simulated file operations. In a real app, you would use
/// `dart:io` and `path_provider` packages for actual file operations.
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => FileOperationsExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';
// Note: In a real implementation, you would use dart:io and path_provider
// import 'dart:io';

/// Main widget demonstrating file operations.
///
/// Shows how to read, write, and delete files locally.
class FileOperationsExample extends StatefulWidget {
  const FileOperationsExample({super.key});

  @override
  State<FileOperationsExample> createState() => _FileOperationsExampleState();
}

class _FileOperationsExampleState extends State<FileOperationsExample> {
  final TextEditingController _contentController = TextEditingController();
  String _filePath = '';
  String _fileContent = '';
  String _error = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveFile() async {
    if (_contentController.text.isEmpty) {
      setState(() {
        _error = 'Please enter some content';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      // In a real implementation, you would use path_provider and dart:io
      // final directory = await getApplicationDocumentsDirectory();
      // final file = File('${directory.path}/example.txt');
      // await file.writeAsString(_contentController.text);

      // Demo implementation
      _filePath = '/documents/example.txt';
      _fileContent = _contentController.text;

      setState(() {
        _error = '';
      });

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('File saved successfully!')));
    } catch (e) {
      setState(() {
        _error = 'Error saving file: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _readFile() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      // In a real implementation:
      // final directory = await getApplicationDocumentsDirectory();
      // final file = File('${directory.path}/example.txt');
      // final content = await file.readAsString();

      // Demo implementation
      if (_fileContent.isEmpty) {
        setState(() {
          _error = 'No file content available';
        });
      } else {
        _contentController.text = _fileContent;
        setState(() {
          _error = '';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error reading file: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteFile() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      // In a real implementation:
      // final directory = await getApplicationDocumentsDirectory();
      // final file = File('${directory.path}/example.txt');
      // await file.delete();

      // Demo implementation
      _filePath = '';
      _fileContent = '';
      _contentController.clear();

      setState(() {
        _error = '';
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File deleted successfully!')),
      );
    } catch (e) {
      setState(() {
        _error = 'Error deleting file: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Operations')),
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
                      'File Content',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _contentController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Enter file content here...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _saveFile,
                            icon: const Icon(Icons.save),
                            label: const Text('Save File'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _isLoading ? null : _readFile,
                            icon: const Icon(Icons.folder_open),
                            label: const Text('Read File'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _isLoading ? null : _deleteFile,
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete File'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_filePath.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'File Info',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Path: $_filePath'),
                      const SizedBox(height: 4),
                      Text('Size: ${_fileContent.length} characters'),
                    ],
                  ),
                ),
              ),
            ],
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
            if (_isLoading) ...[
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
            ],
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Platform-Specific Implementation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'To use file operations:\n'
                      '1. Add path_provider package\n'
                      '2. Get directory: getApplicationDocumentsDirectory()\n'
                      '3. Create File from path\n'
                      '4. Use readAsString() / writeAsString()\n'
                      '5. This is a demo showing the concept',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
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
