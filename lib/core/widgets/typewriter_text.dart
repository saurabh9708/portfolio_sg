import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration typingDelay;
  final Duration deletingDelay;
  final Duration pauseDelay;

  const TypewriterText({
    super.key,
    required this.texts,
    this.style,
    this.typingDelay = const Duration(milliseconds: 100),
    this.deletingDelay = const Duration(milliseconds: 50),
    this.pauseDelay = const Duration(milliseconds: 2000),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  String _currentText = '';
  bool _isTyping = true;
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _startAnimation();
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  void _startAnimation() async {
    while (mounted) {
      if (_isTyping) {
        final targetText = widget.texts[_currentIndex];
        if (_currentText.length < targetText.length) {
          setState(() {
            _currentText = targetText.substring(0, _currentText.length + 1);
          });
          await Future.delayed(widget.typingDelay);
        } else {
          _isTyping = false;
          await Future.delayed(widget.pauseDelay);
        }
      } else {
        if (_currentText.isNotEmpty) {
          setState(() {
            _currentText = _currentText.substring(0, _currentText.length - 1);
          });
          await Future.delayed(widget.deletingDelay);
        } else {
          _isTyping = true;
          _currentIndex = (_currentIndex + 1) % widget.texts.length;
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _currentText,
          style: widget.style,
        ),
        FadeTransition(
          opacity: _cursorController,
          child: Container(
            width: 3,
            height: (widget.style?.fontSize ?? 24) * 0.9,
            color: AppColors.accentColor,
            margin: const EdgeInsets.only(left: 4, bottom: 2),
          ),
        ),
      ],
    );
  }
}
