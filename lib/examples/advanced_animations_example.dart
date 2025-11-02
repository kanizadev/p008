import 'package:flutter/material.dart';
import 'dart:math' as math;

class AdvancedAnimationsExample extends StatefulWidget {
  const AdvancedAnimationsExample({super.key});

  @override
  State<AdvancedAnimationsExample> createState() =>
      _AdvancedAnimationsExampleState();
}

class _AdvancedAnimationsExampleState extends State<AdvancedAnimationsExample>
    with TickerProviderStateMixin {
  late AnimationController _springController;
  late AnimationController _staggeredController;
  late AnimationController _physicsController;
  late Animation<double> _springAnimation;
  final List<Animation<double>> _staggeredAnimations = [];

  @override
  void initState() {
    super.initState();

    // Spring Animation
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _springAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _springController, curve: Curves.elasticOut),
    );

    // Staggered Animation
    _staggeredController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    const itemCount = 5;
    const staggerDelay = 0.15;
    const staggerDuration = 0.4;

    for (int i = 0; i < itemCount; i++) {
      final start = (i * staggerDelay).clamp(0.0, 1.0);
      final calculatedEnd = (i * staggerDelay) + staggerDuration;
      // Ensure end value is within valid range and greater than start
      final end = calculatedEnd.clamp(start, 1.0);

      _staggeredAnimations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _staggeredController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );
    }

    // Physics Animation
    _physicsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _springController.dispose();
    _staggeredController.dispose();
    _physicsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Animations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSpringAnimation(),
            const SizedBox(height: 24),
            _buildStaggeredAnimation(),
            const SizedBox(height: 24),
            _buildPhysicsAnimation(),
            const SizedBox(height: 24),
            _buildComplexAnimation(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpringAnimation() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spring Animation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Center(
              child: AnimatedBuilder(
                animation: _springAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _springAnimation.value,
                    child: Transform.rotate(
                      angle: _springAnimation.value * 2 * math.pi,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.pink],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.whatshot, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _springController.reset();
                _springController.forward();
              },
              child: const Text('Start Spring Animation'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaggeredAnimation() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Staggered Animation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return AnimatedBuilder(
                  animation: _staggeredController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _staggeredAnimations[index].value,
                      child: Opacity(
                        opacity: _staggeredAnimations[index].value,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors
                                .primaries[index % Colors.primaries.length],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_staggeredController.isAnimating) {
                  _staggeredController.stop();
                }
                _staggeredController.reset();
                _staggeredController.forward();
              },
              child: const Text('Start Staggered Animation'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhysicsAnimation() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Physics-based Animation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                height: 200,
                child: _PhysicsBall(controller: _physicsController),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_physicsController.isAnimating) {
                  _physicsController.stop();
                }
                _physicsController.reset();
                _physicsController.forward();
              },
              child: const Text('Drop Ball'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplexAnimation() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complex Multi-Property Animation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const Center(child: _ComplexAnimatedWidget()),
          ],
        ),
      ),
    );
  }
}

class _PhysicsBall extends StatelessWidget {
  final AnimationController controller;

  const _PhysicsBall({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = controller.value;
        // Simulate gravity with realistic physics
        // Using a parabolic trajectory for falling, then multiple bounces with decreasing height
        const maxHeight = 180.0;
        const ballRadius = 20.0;
        double y = ballRadius;

        if (value < 0.35) {
          // Initial fall: y = (1/2)gt^2
          final t = value / 0.35;
          y = ballRadius + (t * t * maxHeight);
        } else if (value < 0.55) {
          // First bounce: reverse the fall
          final bounceT = (value - 0.35) / 0.20;
          final bounceHeight = maxHeight * 0.7; // 70% of original height
          y = ballRadius + maxHeight - (bounceT * bounceT * bounceHeight);
        } else if (value < 0.70) {
          // Second fall
          final t = (value - 0.55) / 0.15;
          final bounceHeight = maxHeight * 0.7;
          y = ballRadius + maxHeight - bounceHeight + (t * t * bounceHeight);
        } else if (value < 0.82) {
          // Second bounce: smaller bounce
          final bounceT = (value - 0.70) / 0.12;
          final bounceHeight = maxHeight * 0.5; // 50% of original
          final prevBounceHeight = maxHeight * 0.7;
          y =
              ballRadius +
              maxHeight -
              prevBounceHeight -
              (bounceT * bounceT * bounceHeight);
        } else if (value < 0.92) {
          // Third fall
          final t = (value - 0.82) / 0.10;
          final bounceHeight = maxHeight * 0.5;
          final prevBounceHeight = maxHeight * 0.7;
          y =
              ballRadius +
              maxHeight -
              prevBounceHeight -
              bounceHeight +
              (t * t * bounceHeight);
        } else {
          // Final settle at bottom
          final settleT = (value - 0.92) / 0.08;
          final finalY = maxHeight;
          final settleOffset = settleT * 5; // Small settle movement
          y = ballRadius + finalY - settleOffset;
        }

        return CustomPaint(painter: _BallPainter(y: y));
      },
    );
  }
}

class _BallPainter extends CustomPainter {
  final double y;

  _BallPainter({required this.y});

  @override
  void paint(Canvas canvas, Size size) {
    const ballRadius = 20.0;

    // Draw ground line
    final groundPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, size.height - ballRadius),
      Offset(size.width, size.height - ballRadius),
      groundPaint,
    );

    // Draw ball shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width / 2, size.height - ballRadius),
      ballRadius * 0.5,
      shadowPaint,
    );

    // Draw ball
    final ballPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, y), ballRadius, ballPaint);

    // Add highlight for 3D effect
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width / 2 - 5, y - 5),
      ballRadius * 0.3,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(_BallPainter oldDelegate) => oldDelegate.y != y;
}

class _ComplexAnimatedWidget extends StatefulWidget {
  const _ComplexAnimatedWidget();

  @override
  State<_ComplexAnimatedWidget> createState() => _ComplexAnimatedWidgetState();
}

class _ComplexAnimatedWidgetState extends State<_ComplexAnimatedWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  late Animation<double> _scale;
  late Animation<Color?> _color;
  late Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _rotation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scale = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _color = ColorTween(
      begin: Colors.blue,
      end: Colors.purple,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _offset = Tween<double>(
      begin: 0,
      end: 50,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _offset.value),
          child: Transform.rotate(
            angle: _rotation.value,
            child: Transform.scale(
              scale: _scale.value,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: _color.value,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color:
                          _color.value?.withValues(alpha: 0.5) ??
                          Colors.transparent,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 50),
              ),
            ),
          ),
        );
      },
    );
  }
}
