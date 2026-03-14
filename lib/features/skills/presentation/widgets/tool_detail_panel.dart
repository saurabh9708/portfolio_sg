import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/skill_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ToolDetailContent extends StatelessWidget {
  final SkillModel skill;

  const ToolDetailContent({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(skill.icon, color: AppColors.accentColor, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  skill.name,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideX(begin: -0.1, end: 0),
          
          const SizedBox(height: 16),
          
          Text(
            skill.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
          ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

          const SizedBox(height: 24),

          // Pros
          Text(
            '✅ Why I love it',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
          ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
          const SizedBox(height: 8),
          ...skill.pros.map((pro) => Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: AppColors.textSecondary)),
                    Expanded(
                      child: Text(
                        pro,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                      ),
                    ),
                  ],
                ),
              )).toList().animate(interval: 50.ms).fadeIn(delay: 450.ms, duration: 400.ms),

          const SizedBox(height: 16),

          // Cons
          Text(
            '❌ Limitations',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
          ).animate().fadeIn(delay: 550.ms, duration: 400.ms),
          const SizedBox(height: 8),
          ...skill.cons.map((con) => Padding(
                padding: const EdgeInsets.only(bottom: 4, left: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: AppColors.textSecondary)),
                    Expanded(
                      child: Text(
                        con,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                      ),
                    ),
                  ],
                ),
              )).toList().animate(interval: 50.ms).fadeIn(delay: 600.ms, duration: 400.ms),

          const SizedBox(height: 32),

          // Used in
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.build_circle, color: AppColors.secondaryAccent, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Used in: ${skill.projectsUsedIn}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 750.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }
}
