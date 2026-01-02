
import 'dart:math';
import 'package:flutter/material.dart';

class FairyEffectWidget extends StatefulWidget {
  final Widget child;
  const FairyEffectWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<FairyEffectWidget> createState() => _FairyEffectWidgetState();
}

class _FairyEffectWidgetState extends State<FairyEffectWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    // Initialize particles
    for (int i = 0; i < 20; i++) {
      _particles.add(_createParticle());
    }
  }

  _Particle _createParticle() {
    return _Particle(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      size: _random.nextDouble() * 4 + 2,
      opacity: _random.nextDouble(),
      speed: _random.nextDouble() * 0.02 + 0.005,
      angle: _random.nextDouble() * 2 * pi,
    );
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
        // Update particles
        for (var particle in _particles) {
          particle.y -= particle.speed;
          particle.opacity -= 0.01;
          if (particle.opacity <= 0 || particle.y < 0) {
            // Reset particle
            particle.y = 1.0;
            particle.x = _random.nextDouble();
            particle.opacity = 1.0;
          }
        }
        return Stack(
          children: [
            widget.child,
            Positioned.fill(
              child: CustomPaint(
                painter: _FairyDustPainter(_particles),
              ),
            ),
             Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   border: Border.all(
                      color: Colors.white.withOpacity(0.8 * (0.5 + 0.5 * sin(_controller.value * 2 * pi))),
                      width: 2,
                   ),
                   boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.6),
                        blurRadius: 10 * sin(_controller.value * pi),
                        spreadRadius: 2,
                      )
                   ]
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Particle {
  double x;
  double y;
  double size;
  double opacity;
  double speed;
  double angle;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.speed,
    required this.angle,
  });
}

class _FairyDustPainter extends CustomPainter {
  final List<_Particle> particles;

  _FairyDustPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (var particle in particles) {
      paint.color = Colors.white.withOpacity(particle.opacity.clamp(0.0, 1.0));
      final dx = particle.x * size.width;
      final dy = particle.y * size.height;
      
      // Draw a little star or circle
      canvas.drawCircle(Offset(dx, dy), particle.size / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
