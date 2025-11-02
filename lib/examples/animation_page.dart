import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAnimationCard(
            context,
            'Implicit Animations',
            'AnimatedContainer, AnimatedOpacity, etc.',
            const _ImplicitAnimationsExample(),
          ),
          _buildAnimationCard(
            context,
            'Explicit Animations',
            'AnimationController based animations',
            const _ExplicitAnimationsExample(),
          ),
          _buildAnimationCard(
            context,
            'Hero Animation',
            'Shared element transitions',
            const _HeroAnimationExample(),
          ),
          _buildAnimationCard(
            context,
            'Page Transitions',
            'Custom page route transitions',
            const _PageTransitionsExample(),
          ),
          _buildAnimationCard(
            context,
            'Animated List',
            'List with animated insertions/deletions',
            const _AnimatedListExample(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationCard(
    BuildContext context,
    String title,
    String subtitle,
    Widget destination,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    );
  }
}

class _ImplicitAnimationsExample extends StatefulWidget {
  const _ImplicitAnimationsExample();

  @override
  State<_ImplicitAnimationsExample> createState() =>
      _ImplicitAnimationsExampleState();
}

class _ImplicitAnimationsExampleState
    extends State<_ImplicitAnimationsExample> {
  bool _isExpanded = false;
  bool _isVisible = true;
  double _padding = 16.0;
  Color _color = Colors.blue;
  double _rotation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Implicit Animations')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'AnimatedContainer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: _isExpanded ? 250 : 150,
              height: _isExpanded ? 250 : 150,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(_isExpanded ? 50 : 10),
              ),
              child: const Center(
                child: Text(
                  'Tap to animate',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                  _color = _isExpanded ? Colors.purple : Colors.blue;
                });
              },
              child: const Text('Toggle Container'),
            ),
            const SizedBox(height: 32),
            const Text(
              'AnimatedOpacity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Container(
                width: 200,
                height: 100,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'Fade In/Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: const Text('Toggle Visibility'),
            ),
            const SizedBox(height: 32),
            const Text(
              'AnimatedPadding',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              color: Colors.grey[300],
              child: AnimatedPadding(
                padding: EdgeInsets.all(_padding),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Container(
                  color: Colors.orange,
                  height: 100,
                  child: const Center(
                    child: Text(
                      'Animated Padding',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _padding = _padding == 16.0 ? 48.0 : 16.0;
                });
              },
              child: const Text('Toggle Padding'),
            ),
            const SizedBox(height: 32),
            const Text(
              'AnimatedRotation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            AnimatedRotation(
              turns: _rotation,
              duration: const Duration(seconds: 1),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: const Icon(Icons.refresh, color: Colors.white, size: 50),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _rotation += 0.25;
                });
              },
              child: const Text('Rotate 90°'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplicitAnimationsExample extends StatefulWidget {
  const _ExplicitAnimationsExample();

  @override
  State<_ExplicitAnimationsExample> createState() =>
      _ExplicitAnimationsExampleState();
}

class _ExplicitAnimationsExampleState extends State<_ExplicitAnimationsExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explicit Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Scale & Color Animation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _colorAnimation.value,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.forward();
                  },
                  child: const Text('Forward'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    _controller.reverse();
                  },
                  child: const Text('Reverse'),
                ),
              ],
            ),
            const SizedBox(height: 48),
            const Text(
              'Rotation Animation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationController.value * 2 * math.pi,
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.green,
                    child: const Icon(
                      Icons.sync,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroAnimationExample extends StatelessWidget {
  const _HeroAnimationExample();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animation')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(6, (index) {
          final color = Colors.primaries[index % Colors.primaries.length];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      _HeroDetailScreen(tag: 'hero-$index', color: color),
                ),
              );
            },
            child: Hero(
              tag: 'hero-$index',
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Item ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _HeroDetailScreen extends StatelessWidget {
  final String tag;
  final Color color;

  const _HeroDetailScreen({required this.tag, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Detail')),
      body: Center(
        child: Hero(
          tag: tag,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(
              child: Text(
                'Hero Animation!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PageTransitionsExample extends StatelessWidget {
  const _PageTransitionsExample();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Transitions')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  _createSlideTransition(
                    const _TransitionDestinationScreen(
                      title: 'Slide Transition',
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              child: const Text('Slide Transition'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  _createFadeTransition(
                    const _TransitionDestinationScreen(
                      title: 'Fade Transition',
                      color: Colors.green,
                    ),
                  ),
                );
              },
              child: const Text('Fade Transition'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  _createScaleTransition(
                    const _TransitionDestinationScreen(
                      title: 'Scale Transition',
                      color: Colors.purple,
                    ),
                  ),
                );
              },
              child: const Text('Scale Transition'),
            ),
          ],
        ),
      ),
    );
  }

  Route _createSlideTransition(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  Route _createFadeTransition(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  Route _createScaleTransition(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.elasticOut),
          ),
          child: child,
        );
      },
    );
  }
}

class _TransitionDestinationScreen extends StatelessWidget {
  final String title;
  final Color color;

  const _TransitionDestinationScreen({
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: color),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedListExample extends StatefulWidget {
  const _AnimatedListExample();

  @override
  State<_AnimatedListExample> createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<_AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3'];
  int _counter = 3;

  void _addItem() {
    _counter++;
    final index = _items.length;
    _items.add('Item $_counter');
    _listKey.currentState?.insertItem(index);
  }

  void _removeItem(int index) {
    final removedItem = _items[index];
    _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation),
    );
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              final index = _items.indexOf(item);
              if (index != -1) {
                _removeItem(index);
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated List')),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_items[index], animation);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
