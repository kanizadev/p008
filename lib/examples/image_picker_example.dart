/// Image Picker Example
///
/// Demonstrates image selection functionality in Flutter.
/// This example showcases:
/// - Gallery selection: Picking images from device gallery
/// - Camera capture: Taking photos with device camera
/// - Image display: Showing selected images
/// - Error handling: Managing picker errors
///
/// Note: This is a conceptual example. In a real app, you would use
/// packages like `image_picker` for actual image selection.
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => ImagePickerExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';
import 'dart:io';

/// Main widget demonstrating image picker functionality.
///
/// Shows how to pick images from gallery or camera.
class ImagePickerExample extends StatefulWidget {
  const ImagePickerExample({super.key});

  @override
  State<ImagePickerExample> createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<ImagePickerExample> {
  File? _imageFile;
  String _imageSource = 'No image selected';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Select Image Source',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _showImageSourceDialog('Camera'),
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Camera'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _showImageSourceDialog('Gallery'),
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Gallery'),
                          ),
                        ),
                      ],
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
                  children: [
                    const Text(
                      'Selected Image',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_imageFile != null) ...[
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_imageFile!, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Source: $_imageSource',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _imageFile = null;
                            _imageSource = 'No image selected';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Remove Image'),
                      ),
                    ] else ...[
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _imageSource,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                      'Platform-Specific Implementation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'To use image_picker package:\n'
                      '1. Add image_picker to pubspec.yaml\n'
                      '2. Request permissions (camera, storage)\n'
                      '3. Use ImagePicker().pickImage() method\n'
                      '4. This is a demo UI showing the concept',
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

  void _showImageSourceDialog(String source) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select from $source'),
        content: Text(
          'In a real implementation, this would open the $source to select an image.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Simulate image selection
              setState(() {
                _imageSource = source;
                // In real implementation, this would be the actual file path
                // _imageFile = File(pickedImage.path);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$source selection would be implemented here'),
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
