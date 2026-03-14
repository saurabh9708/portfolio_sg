import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TopNavBar extends StatelessWidget {
  final ScrollController scrollController;
  final bool isScrolled;
  final Function(int) onNavTap;
  final int activeIndex;

  const TopNavBar({
    super.key,
    required this.scrollController,
    required this.isScrolled,
    required this.onNavTap,
    required this.activeIndex,
  });

  static const List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Contact'
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppSizes.animDurationMedium,
      curve: AppSizes.curveOut,
      height: 80,
      decoration: BoxDecoration(
        color: isScrolled
            ? AppColors.surfaceColor.withOpacity(0.85)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppColors.border : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ColorFilter.mode(
            Colors.black.withOpacity(isScrolled ? 0.2 : 0.0),
            BlendMode.srcOver,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxContentWidth),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.sectionPaddingHTablet),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    _buildLogo(context),
                    
                    // Nav Items
                    Row(
                      children: [
                        ...List.generate(navItems.length, (index) {
                          return _buildNavItem(context, navItems[index], index);
                        }),
                        const SizedBox(width: 24),
                        _buildHireMeButton(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Text(
      'S.',
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppColors.accentColor,
            fontWeight: FontWeight.w900,
          ),
    ).animate().scale(delay: 200.ms, duration: 500.ms, curve: Curves.easeOutBack)
    .rotate(begin: -0.2, end: 0);
  }

  Widget _buildNavItem(BuildContext context, String title, int index) {
    final isActive = activeIndex == index;
    return InkWell(
      onTap: () => onNavTap(index),
      borderRadius: BorderRadius.circular(8),
      hoverColor: Colors.white.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              height: 2,
              width: isActive ? 24 : 0,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHireMeButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.floatShadow,
            blurRadius: 12,
            spreadRadius: 2,
          )
        ],
      ),
      child: OutlinedButton.icon(
        onPressed: () {
          // Scroll to contact
          onNavTap(4);
        },
        icon: const Icon(Icons.play_arrow, size: 16, color: AppColors.accentColor),
        label: Text(
          'Hire Me',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.accentColor, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
    .boxShadow(
      begin: const BoxShadow(color: Color(0x0000E5FF), blurRadius: 0),
      end: const BoxShadow(color: Color(0x3300E5FF), blurRadius: 12, spreadRadius: 2),
      duration: 1500.ms,
    );
  }
}
