import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_util.dart';
import '../../domain/models/experience_model.dart';

class ExperienceNode extends StatefulWidget {
  final ExperienceModel experience;
  final bool isLeft; // For alternating desktop layout

  const ExperienceNode({
    super.key,
    required this.experience,
    required this.isLeft,
  });

  @override
  State<ExperienceNode> createState() => _ExperienceNodeState();
}

class _ExperienceNodeState extends State<ExperienceNode> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surfaceColor.withOpacity(0.9) : AppColors.cardBackground.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? AppColors.accentColor.withOpacity(0.4) : AppColors.border,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.accentColor.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Duration Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.experience.role,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (!isMobile) _buildDurationBadge(context),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.business, size: 16, color: AppColors.accentColor),
                const SizedBox(width: 8),
                Text(
                  widget.experience.company,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('•', style: TextStyle(color: AppColors.textSecondary)),
                ),
                Icon(Icons.location_on, size: 14, color: AppColors.textSecondary.withOpacity(0.8)),
                const SizedBox(width: 4),
                Text(
                  widget.experience.location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary.withOpacity(0.8),
                      ),
                ),
              ],
            ),
            if (isMobile) ...[
              const SizedBox(height: 12),
              _buildDurationBadge(context),
            ],
            const SizedBox(height: 20),
            
            // Bullet Points
            ...widget.experience.bulletPoints.map((point) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6.0, right: 12.0),
                      child: Icon(Icons.circle, size: 6, color: AppColors.accentColor),
                    ),
                    Expanded(
                      child: Text(
                        point,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary.withOpacity(0.9),
                              height: 1.6,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),
            
            // Tech Stack
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.experience.techStack.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.secondaryAccent.withOpacity(0.2)),
                  ),
                  child: Text(
                    tech,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.secondaryAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentColor.withOpacity(0.3)),
      ),
      child: Text(
        widget.experience.duration,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.accentColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
