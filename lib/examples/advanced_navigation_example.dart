import 'package:flutter/material.dart';

class AdvancedNavigationExample extends StatelessWidget {
  const AdvancedNavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Navigation'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Navigator(
        onGenerateRoute: (settings) {
          if (settings.name == '/advanced-detail') {
            final args = settings.arguments;
            Map<String, dynamic> arguments = {};
            if (args is Map) {
              arguments = Map<String, dynamic>.from(args);
            }
            return MaterialPageRoute(
              builder: (_) => _NamedRouteDetailPage(
                title: arguments['title'] as String? ?? 'Detail Page',
                id: arguments['id'] as int? ?? 0,
              ),
            );
          }
          // Default route - the list of navigation examples
          return MaterialPageRoute(
            builder: (routeContext) => Builder(
              builder: (builderContext) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildCard(
                    builderContext,
                    'Custom Route Transitions',
                    'Slide, fade, scale transitions',
                    Icons.swap_horiz,
                    () => Navigator.push(
                      builderContext,
                      _CustomSlideRoute(
                        const _TransitionPage(title: 'Slide Transition'),
                      ),
                    ),
                  ),
                  _buildCard(
                    builderContext,
                    'Nested Navigation',
                    'Navigator within Navigator',
                    Icons.layers,
                    () => Navigator.push(
                      builderContext,
                      MaterialPageRoute(
                        builder: (_) => const _NestedNavigationExample(),
                      ),
                    ),
                  ),
                  _buildCard(
                    builderContext,
                    'Named Routes Example',
                    'Using route names and arguments',
                    Icons.route,
                    () => Navigator.pushNamed(
                      builderContext,
                      '/advanced-detail',
                      arguments: {'title': 'Passed via Arguments', 'id': 123},
                    ),
                  ),
                  _buildCard(
                    builderContext,
                    'WillPopScope Example',
                    'Handle back button behavior',
                    Icons.arrow_back,
                    () => Navigator.push(
                      builderContext,
                      MaterialPageRoute(
                        builder: (_) => const _WillPopScopeExample(),
                      ),
                    ),
                  ),
                  _buildCard(
                    builderContext,
                    'Full Screen Dialog',
                    'Modal full screen route',
                    Icons.fullscreen,
                    () => Navigator.push(
                      builderContext,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => const _FullScreenDialogExample(),
                      ),
                    ),
                  ),
                  _buildCard(
                    builderContext,
                    'Pop with Result',
                    'Return data from navigation',
                    Icons.call_made,
                    () => _showPopWithResult(builderContext),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(
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

  Future<void> _showPopWithResult(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const _PopWithResultExample()),
    );

    if (context.mounted && result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Returned value: $result'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}

class _CustomSlideRoute extends PageRouteBuilder {
  final Widget page;

  _CustomSlideRoute(this.page)
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      );
}

class _TransitionPage extends StatelessWidget {
  final String title;

  const _TransitionPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.swap_horiz, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NestedNavigationExample extends StatelessWidget {
  const _NestedNavigationExample();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nested Navigation')),
      body: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => _NestedPage());
        },
      ),
    );
  }
}

class _NestedPage extends StatelessWidget {
  final GlobalKey<NavigatorState> _nestedNavigatorKey =
      GlobalKey<NavigatorState>();

  _NestedPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _nestedNavigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.layers, size: 80, color: Colors.purple),
                  const SizedBox(height: 20),
                  const Text(
                    'Nested Navigator',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _nestedNavigatorKey.currentState?.push(
                        MaterialPageRoute(
                          builder: (_) => const Scaffold(
                            body: Center(
                              child: Text(
                                'This is a nested page!\nYou can navigate within this nested navigator.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text('Navigate in Nested Navigator'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Go Back to Parent'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WillPopScopeExample extends StatelessWidget {
  const _WillPopScopeExample();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to go back?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          );

          if (shouldPop == true && context.mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('WillPopScope Example')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, size: 80, color: Colors.orange),
              SizedBox(height: 20),
              Text('Try pressing back button', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text(
                'A confirmation dialog will appear',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FullScreenDialogExample extends StatelessWidget {
  const _FullScreenDialogExample();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Screen Dialog'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Saved!')));
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fullscreen, size: 80, color: Colors.teal),
            SizedBox(height: 20),
            Text(
              'Full Screen Dialog',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'This opens as a full screen dialog',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _PopWithResultExample extends StatelessWidget {
  const _PopWithResultExample();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pop with Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.call_made, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Pop with Result',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Hello from Pop!'),
              child: const Text('Pop with Result'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 42),
              child: const Text('Pop with Number'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Pop without Result'),
            ),
          ],
        ),
      ),
    );
  }
}

// Named route detail page
class _NamedRouteDetailPage extends StatelessWidget {
  final String title;
  final int id;

  const _NamedRouteDetailPage({required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Named Route Detail')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.route, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: $id',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'This page was navigated to using a named route.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Arguments were passed via the route settings.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
