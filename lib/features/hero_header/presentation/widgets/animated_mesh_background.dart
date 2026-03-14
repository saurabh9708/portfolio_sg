import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AnimatedMeshBackground extends StatefulWidget {
  const AnimatedMeshBackground({super.key});

  @override
  State<AnimatedMeshBackground> createState() => _AnimatedMeshBackgroundState();
}

class _AnimatedMeshBackgroundState extends State<AnimatedMeshBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _MeshPainter(_controller.value),
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: const DecorationImage(
              image: AssetImage('assets/images/noise.png'), // Will add a noise asset or mock it
              opacity: 0.03,
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),
      ),
    );
  }
}

class _MeshPainter extends CustomPainter {
  final double progress;

  _MeshPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    // Orb 1: Cyan
    _drawOrb(
      canvas,
      paint,
      color: AppColors.accentColor.withOpacity(0.15),
      center: Offset(
        size.width * 0.2 + sin(progress * pi * 2) * size.width * 0.1,
        size.height * 0.3 + cos(progress * pi * 2) * size.height * 0.1,
      ),
      radius: size.width * 0.4,
    );

    // Orb 2: Violet
    _drawOrb(
      canvas,
      paint,
      color: AppColors.secondaryAccent.withOpacity(0.15),
      center: Offset(
        size.width * 0.7 + cos(progress * pi * 2 * 0.8) * size.width * 0.15,
        size.height * 0.6 + sin(progress * pi * 2 * 0.8) * size.height * 0.1,
      ),
      radius: size.width * 0.5,
    );

    // Orb 3: Dark Blue
    _drawOrb(
      canvas,
      paint,
      color: const Color(0xFF0033FF).withOpacity(0.1),
      center: Offset(
        size.width * 0.5 + sin(progress * pi * 2 * 1.5) * size.width * 0.1,
        size.height * 0.8 + cos(progress * pi * 2 * 1.5) * size.height * 0.1,
      ),
      radius: size.width * 0.6,
    );
  }

  void _drawOrb(Canvas canvas, Paint paint, {required Color color, required Offset center, required double radius}) {
    paint.color = color;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _MeshPainter oldDelegate) => oldDelegate.progress != progress;
}
