/// Advanced Forms Example
///
/// Demonstrates advanced form patterns in Flutter.
/// This example showcases:
/// - Multi-step forms with progress indicators
/// - Dynamic form fields
/// - Form validation with custom validators
/// - Real-time validation feedback
/// - Conditional form fields
/// - Form state persistence
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (_) => AdvancedFormsExample()),
/// );
/// ```
library;

import 'package:flutter/material.dart';

/// Main widget demonstrating advanced form patterns.
///
/// Shows multi-step forms, dynamic fields, and advanced validation.
class AdvancedFormsExample extends StatefulWidget {
  const AdvancedFormsExample({super.key});

  @override
  State<AdvancedFormsExample> createState() => _AdvancedFormsExampleState();
}

class _AdvancedFormsExampleState extends State<AdvancedFormsExample> {
  int _currentStep = 0;
  final _stepOneKey = GlobalKey<FormState>();
  final _stepTwoKey = GlobalKey<FormState>();
  final _stepThreeKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  String _city = '';
  String _country = 'USA';
  bool _hasAddress = false;
  final List<String> _interests = [];
  final List<String> _availableInterests = [
    'Flutter',
    'Dart',
    'Mobile Development',
    'UI/UX Design',
    'Backend Development',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Forms')),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: SingleChildScrollView(
              child: Stepper(
                currentStep: _currentStep,
                onStepContinue: _continueStep,
                onStepCancel: _cancelStep,
                steps: [_buildStepOne(), _buildStepTwo(), _buildStepThree()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: List.generate(3, (index) {
          final isActive = index <= _currentStep;
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
              decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Step _buildStepOne() {
    return Step(
      title: const Text('Personal Information'),
      content: Form(
        key: _stepOneKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                if (value.length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
              onSaved: (value) => _name = value ?? '',
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onSaved: (value) => _email = value ?? '',
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (value.length < 10) {
                  return 'Phone number must be at least 10 digits';
                }
                return null;
              },
              onSaved: (value) => _phone = value ?? '',
            ),
          ],
        ),
      ),
    );
  }

  Step _buildStepTwo() {
    return Step(
      title: const Text('Address Information'),
      content: Form(
        key: _stepTwoKey,
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Include Address'),
              value: _hasAddress,
              onChanged: (value) => setState(() => _hasAddress = value),
            ),
            if (_hasAddress) ...[
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
                onSaved: (value) => _address = value ?? '',
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_city),
                      ),
                      onSaved: (value) => _city = value ?? '',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _country,
                      decoration: const InputDecoration(
                        labelText: 'Country',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.public),
                      ),
                      items: ['USA', 'Canada', 'UK', 'Germany', 'France']
                          .map(
                            (country) => DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _country = value ?? 'USA'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Step _buildStepThree() {
    return Step(
      title: const Text('Additional Information'),
      content: Form(
        key: _stepThreeKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Your Interests',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableInterests.map((interest) {
                final isSelected = _interests.contains(interest);
                return FilterChip(
                  label: Text(interest),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _interests.add(interest);
                      } else {
                        _interests.remove(interest);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Name: $_name'),
                    Text('Email: $_email'),
                    Text('Phone: $_phone'),
                    if (_hasAddress) ...[
                      Text('Address: $_address'),
                      Text('City: $_city'),
                      Text('Country: $_country'),
                    ],
                    Text('Interests: ${_interests.join(", ")}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _continueStep() {
    switch (_currentStep) {
      case 0:
        if (_stepOneKey.currentState!.validate()) {
          _stepOneKey.currentState!.save();
          setState(() => _currentStep++);
        }
        break;
      case 1:
        if (_stepTwoKey.currentState!.validate()) {
          _stepTwoKey.currentState!.save();
          setState(() => _currentStep++);
        }
        break;
      case 2:
        _submitForm();
        break;
    }
  }

  void _cancelStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _submitForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Form submitted successfully!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
