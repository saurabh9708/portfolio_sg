import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_util.dart';
import 'widgets/animated_counter.dart';

class AboutSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const AboutSection({super.key, required this.sectionKey});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isVisible = false;
  
  // Keys to trigger the counter animations
  final GlobalKey<AnimatedCounterState> _expKey = GlobalKey();
  final GlobalKey<AnimatedCounterState> _projKey = GlobalKey();
  final GlobalKey<AnimatedCounterState> _clientKey = GlobalKey();

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.3 && !_isVisible) {
      if (mounted) {
        setState(() => _isVisible = true);
        _expKey.currentState?.play();
        _projKey.currentState?.play();
        _clientKey.currentState?.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        key: widget.sectionKey,
        padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPaddingVDesktop),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveLayout.isMobile(context)
                    ? AppSizes.sectionPaddingHMobile
                    : AppSizes.sectionPaddingHTablet,
              ),
              child: ResponsiveLayout(
                mobile: (_) => _buildMobileLayout(context),
                tablet: (_) => _buildDesktopLayout(context),
                desktop: (_) => _buildDesktopLayout(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Text & Bio
        Expanded(
          flex: 1,
          child: _buildTextContent(context).animate(target: _isVisible ? 1 : 0)
              .slideX(begin: -0.1, end: 0, duration: 800.ms, curve: AppSizes.curveOut)
              .fadeIn(duration: 800.ms),
        ),
        const SizedBox(width: 80),
        // Right Column: Stats & Value Props
        Expanded(
          flex: 1,
          child: _buildStatsAndProps(context).animate(target: _isVisible ? 1 : 0)
              .slideX(begin: 0.1, end: 0, duration: 800.ms, curve: AppSizes.curveOut)
              .fadeIn(duration: 800.ms),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextContent(context).animate(target: _isVisible ? 1 : 0)
            .slideY(begin: 0.1, end: 0, duration: 800.ms, curve: AppSizes.curveOut)
            .fadeIn(duration: 800.ms),
        const SizedBox(height: 60),
        _buildStatsAndProps(context).animate(target: _isVisible ? 1 : 0)
            .slideY(begin: 0.1, end: 0, duration: 800.ms, delay: 200.ms, curve: AppSizes.curveOut)
            .fadeIn(duration: 800.ms, delay: 200.ms),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutTitle,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          AppStrings.aboutBio,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.8,
                fontSize: 18,
              ),
        ),
      ],
    );
  }

  Widget _buildStatsAndProps(BuildContext context) {
    return Column(
      children: [
        // Stats Row
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimatedCounter(key: _expKey, targetValue: 3, label: 'Years Exp.'),
              AnimatedCounter(key: _projKey, targetValue: 20, label: 'Projects'),
              AnimatedCounter(key: _clientKey, targetValue: 15, label: 'Clients'),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Value Propositions
        _buildValuePropCard(
          context,
          icon: Icons.rocket_launch,
          title: 'Performance-First',
          color: AppColors.accentColor,
        ),
        const SizedBox(height: 16),
        _buildValuePropCard(
          context,
          icon: Icons.palette,
          title: 'Clean UI/UX',
          color: AppColors.secondaryAccent,
        ),
        const SizedBox(height: 16),
        _buildValuePropCard(
          context,
          icon: Icons.security,
          title: 'Secure & Scalable',
          color: Colors.greenAccent,
        ),
      ],
    );
  }

  Widget _buildValuePropCard(BuildContext context,
      {required IconData icon, required String title, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}
