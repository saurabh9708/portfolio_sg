import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_sizes.dart';

class BottomNavBar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onNavTap;

  const BottomNavBar({
    super.key,
    required this.activeIndex,
    required this.onNavTap,
  });

  static const List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home, 'label': 'Home'},
    {'icon': Icons.person_outline, 'activeIcon': Icons.person, 'label': 'About'},
    {'icon': Icons.build_outlined, 'activeIcon': Icons.build, 'label': 'Skills'},
    {'icon': Icons.folder_outlined, 'activeIcon': Icons.folder, 'label': 'Projects'},
    {'icon': Icons.mail_outline, 'activeIcon': Icons.mail, 'label': 'Contact'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16).copyWith(bottom: MediaQuery.paddingOf(context).bottom + 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor.withOpacity(0.85),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            spreadRadius: 5,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.srcOver,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(navItems.length, (index) {
                return _buildNavItem(context, index);
              }),
            ),
          ),
        ),
      ),
    ).animate().slideY(
      begin: 1.5,
      end: 0,
      duration: 500.ms,
      delay: 400.ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final item = navItems[index];
    final isActive = activeIndex == index;

    return GestureDetector(
      onTap: () => onNavTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppSizes.animDurationFast,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isActive ? 1.2 : 1.0,
              duration: AppSizes.animDurationFast,
              child: Icon(
                isActive ? item['activeIcon'] : item['icon'],
                color: isActive ? AppColors.accentColor : AppColors.textSecondary.withOpacity(0.6),
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            if (isActive)
              AnimatedOpacity(
                opacity: isActive ? 1.0 : 0.0,
                duration: AppSizes.animDurationFast,
                child: Text(
                  item['label'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.accentColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
