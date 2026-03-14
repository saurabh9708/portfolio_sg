import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_util.dart';
import '../../../hero_header/presentation/widgets/social_links_row.dart'; // Reuse social links

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  bool _isVisible = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.1 && !_isVisible) {
      if (mounted) setState(() => _isVisible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('footer-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Only show social links on Mobile/Tablet in the footer, Web has a fixed side strip
            if (!ResponsiveLayout.isDesktop(context)) ...[
              const SocialLinksRow(vertical: false)
                  .animate(target: _isVisible ? 1 : 0)
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2),
              const SizedBox(height: 32),
            ],
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                children: const [
                  TextSpan(text: 'Built with '),
                  TextSpan(
                    text: 'Flutter',
                    style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' & '),
                  TextSpan(
                    text: '❤️',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  TextSpan(text: ' by '),
                  TextSpan(
                    text: 'Saurabh',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2),
            const SizedBox(height: 12),
            Text(
              'Copyright © ${DateTime.now().year}. All rights reserved.',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary.withOpacity(0.6),
                  ),
            ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2),
            
            // Give space for mobile BottomNavBar
            if (ResponsiveLayout.isMobile(context)) const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
