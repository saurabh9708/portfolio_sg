import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int targetValue;
  final String label;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    required this.label,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<AnimatedCounter> createState() => AnimatedCounterState();
}

class AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: widget.targetValue.toDouble()).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );
    // Animation is triggered by visibility detector in the parent widget
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void play() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: [
            Text(
              '${_animation.value.toInt()}+',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
