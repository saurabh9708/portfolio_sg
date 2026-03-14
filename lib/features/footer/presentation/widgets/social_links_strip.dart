import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_util.dart';
import '../../../hero_header/presentation/widgets/social_links_row.dart';

class SocialLinksStrip extends StatelessWidget {
  const SocialLinksStrip({super.key});

  @override
  Widget build(BuildContext context) {
    if (!ResponsiveLayout.isDesktop(context)) {
      return const SizedBox.shrink(); // Hidden on mobile/tablet
    }

    return Positioned(
      left: 40,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SocialLinksRow(isVertical: true),
          const SizedBox(height: 24),
          // Vertical Connecting Line
          Container(
            width: 2,
            height: 100,
            color: AppColors.border,
          ),
        ],
      ).animate().fadeIn(delay: 1500.ms, duration: 800.ms).slideY(begin: 0.2),
    );
  }
}
