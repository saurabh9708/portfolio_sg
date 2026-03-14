import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/responsive_util.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({super.key});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 10))
      ..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = ResponsiveLayout.isMobile(context) ? 150 : 280;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Glowing Background
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.accentColor.withOpacity(0.2),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
        
        // Rotating Gradient Border
        AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationController.value * 2 * pi,
              child: Container(
                width: size + 6,
                height: size + 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      AppColors.accentColor,
                      AppColors.secondaryAccent,
                      AppColors.accentColor,
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // Profile Image Content
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0), // space for border
            child: ClipOval(
              child: Image.asset(
                AppAssets.profileImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: AppColors.surfaceColor),
              ),
            ),
          ),
        ),
      ],
    ).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveY(
          begin: -8,
          end: 8,
          duration: 3.seconds,
          curve: Curves.easeInOutSine,
        );
  }
}
