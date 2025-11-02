/// Networking & API Example
///
/// Demonstrates HTTP requests and API interactions in Flutter.
/// This example showcases:
/// - GET requests: Fetching data from APIs
/// - POST requests: Sending data to APIs
/// - JSON parsing: Handling JSON responses
/// - Error handling: Managing network errors
/// - Loading states: Displaying loading indicators
///
/// Note: This uses simulated API calls. In a real app, you would use
/// packages like `http` or `dio` for actual HTTP requests.
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => NetworkingExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';
import 'dart:convert';
// Note: In a real implementation, you would use the http package
// import 'package:http/http.dart' as http;

/// Main widget demonstrating networking and API interactions.
///
/// Shows how to make HTTP requests and handle JSON responses.
class NetworkingExample extends StatefulWidget {
  const NetworkingExample({super.key});

  @override
  State<NetworkingExample> createState() => _NetworkingExampleState();
}

class _NetworkingExampleState extends State<NetworkingExample> {
  bool _isLoading = false;
  String _response = '';
  String _error = '';
  List<Map<String, dynamic>> _posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Networking & API')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              'GET Request',
              'Fetch data from API',
              Icons.download,
              _fetchData,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'POST Request',
              'Send data to API',
              Icons.upload,
              _postData,
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Fetch List',
              'Get list of posts',
              Icons.list,
              _fetchPosts,
            ),
            if (_isLoading) ...[
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
            ],
            if (_error.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                color: Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Error:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_error),
                    ],
                  ),
                ),
              ),
            ],
            if (_response.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Response:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        _response,
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (_posts.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Posts:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._posts.map(
                (post) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(post['title'] ?? 'No title'),
                    subtitle: Text(post['body'] ?? 'No body'),
                    leading: CircleAvatar(child: Text('${post['id'] ?? 0}')),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
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

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = '';
      _response = '';
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    try {
      // In a real implementation:
      // final response = await http.get(
      //   Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      // );

      // Demo response
      final mockResponse = {
        'userId': 1,
        'id': 1,
        'title': 'Example Post Title',
        'body': 'This is the body of the post from a simulated API call.',
      };

      setState(() {
        _response = const JsonEncoder.withIndent('  ').convert(mockResponse);
      });
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _postData() async {
    setState(() {
      _isLoading = true;
      _error = '';
      _response = '';
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    try {
      // In a real implementation:
      // final response = await http.post(
      //   Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode({
      //     'title': 'Flutter Example',
      //     'body': 'This is a test post from Flutter',
      //     'userId': 1,
      //   }),
      // );

      // Demo response
      final mockResponse = {
        'id': 101,
        'title': 'Flutter Example',
        'body': 'This is a test post from Flutter',
        'userId': 1,
      };

      setState(() {
        _response = const JsonEncoder.withIndent('  ').convert(mockResponse);
      });
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
      _error = '';
      _posts = [];
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    try {
      // In a real implementation:
      // final response = await http.get(
      //   Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5'),
      // );

      // Demo data
      final mockPosts = [
        {'id': 1, 'title': 'Post 1', 'body': 'Content of post 1'},
        {'id': 2, 'title': 'Post 2', 'body': 'Content of post 2'},
        {'id': 3, 'title': 'Post 3', 'body': 'Content of post 3'},
        {'id': 4, 'title': 'Post 4', 'body': 'Content of post 4'},
        {'id': 5, 'title': 'Post 5', 'body': 'Content of post 5'},
      ];

      setState(() {
        _posts = mockPosts;
      });
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
