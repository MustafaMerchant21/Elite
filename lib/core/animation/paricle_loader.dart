import 'package:flutter/material.dart';
import 'dart:math' as math;

class ParticleLoader extends StatefulWidget {
  const ParticleLoader({super.key});

  @override
  _ParticleLoaderState createState() => _ParticleLoaderState();
}

class _ParticleLoaderState extends State<ParticleLoader> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (_, child) {
          return CustomPaint(
            painter: ParticlePainter(_controller!.value),
          );
        },
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double progress;
  ParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final center = Offset(size.width / 2, size.height / 2);
    final particleRadius = size.width * 0.0875; // 17.5% of 45px
    final orbitRadius = size.width / 2;

    for (int i = 0; i < 13; i++) {
      final angle = (i * (360 / 13) + progress * 360) * (math.pi / 180);
      final particleX = center.dx + orbitRadius * math.cos(angle);
      final particleY = center.dy + orbitRadius * math.sin(angle);
      final particleCenter = Offset(particleX, particleY);

      canvas.drawCircle(particleCenter, particleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
