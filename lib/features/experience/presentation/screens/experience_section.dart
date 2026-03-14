import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive_util.dart';
import '../../data/experience_data.dart';
import '../widgets/experience_node.dart';

class ExperienceSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const ExperienceSection({super.key, required this.sectionKey});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _lineController;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _lineController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.1 && !_isVisible) {
      if (mounted) {
        setState(() => _isVisible = true);
        _lineController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('experience-section'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.experienceTitle,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(duration: 600.ms).slideX(begin: -0.1),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms, duration: 600.ms),
                  const SizedBox(height: 64),
                  
                  // Timeline Layout
                  if (ResponsiveLayout.isMobile(context))
                    _buildMobileTimeline()
                  else
                    _buildDesktopTimeline(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopTimeline() {
    final experiences = ExperienceData.experienceList;
    return Stack(
      children: [
        // Center Line drawn from top to bottom
        Positioned.fill(
          child: Center(
            child: AnimatedBuilder(
              animation: _lineController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _TimelineLinePainter(progress: _lineController.value),
                  child: Container(width: 4),
                );
              },
            ),
          ),
        ),
        
        // Nodes
        Column(
          children: List.generate(experiences.length, (index) {
            final isLeft = index % 2 == 0;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Side
                Expanded(
                  child: isLeft
                      ? ExperienceNode(experience: experiences[index], isLeft: true)
                          .animate(target: _isVisible ? 1 : 0)
                          .fadeIn(delay: Duration(milliseconds: 300 + (index * 400)), duration: 600.ms)
                          .slideX(begin: 0.1, end: 0, curve: Curves.easeOutCubic)
                      : const SizedBox(),
                ),
                
                // Center Dot
                _buildTimelineDot(index),

                // Right Side
                Expanded(
                  child: !isLeft
                      ? ExperienceNode(experience: experiences[index], isLeft: false)
                          .animate(target: _isVisible ? 1 : 0)
                          .fadeIn(delay: Duration(milliseconds: 300 + (index * 400)), duration: 600.ms)
                          .slideX(begin: -0.1, end: 0, curve: Curves.easeOutCubic)
                      : const SizedBox(),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMobileTimeline() {
    final experiences = ExperienceData.experienceList;
    return Stack(
      children: [
        // Left Line
        Positioned(
          left: 14,
          top: 0,
          bottom: 0,
          child: AnimatedBuilder(
            animation: _lineController,
            builder: (context, child) {
              return CustomPaint(
                painter: _TimelineLinePainter(progress: _lineController.value),
                child: Container(width: 4),
              );
            },
          ),
        ),
        
        // Nodes
        Column(
          children: List.generate(experiences.length, (index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTimelineDot(index),
                const SizedBox(width: 24),
                Expanded(
                  child: ExperienceNode(experience: experiences[index], isLeft: false)
                      .animate(target: _isVisible ? 1 : 0)
                      .fadeIn(delay: Duration(milliseconds: 300 + (index * 400)), duration: 600.ms)
                      .slideX(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTimelineDot(int index) {
    return Container(
      width: 32,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.accentColor, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentColor.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Center(
        child: Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: AppColors.accentColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ).animate(target: _isVisible ? 1 : 0).scale(
      begin: const Offset(0, 0),
      end: const Offset(1, 1),
      delay: Duration(milliseconds: 200 + (index * 400)),
      duration: 500.ms,
      curve: Curves.elasticOut,
    );
  }
}

class _TimelineLinePainter extends CustomPainter {
  final double progress;

  _TimelineLinePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final double drawHeight = size.height * progress;
    canvas.drawLine(
      const Offset(0, 0),
      Offset(0, drawHeight),
      paint,
    );

    // Glow underneath
    final glowPaint = Paint()
      ..color = AppColors.accentColor.withOpacity(0.5)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawLine(
      const Offset(0, 0),
      Offset(0, drawHeight),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimelineLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
