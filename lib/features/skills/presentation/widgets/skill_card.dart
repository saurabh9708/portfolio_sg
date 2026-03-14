import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/skill_model.dart';

class SkillCard extends StatefulWidget {
  final SkillModel skill;
  final VoidCallback onTap;

  const SkillCard({super.key, required this.skill, required this.onTap});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceColor.withOpacity(0.8) : AppColors.cardBackground.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.accentColor.withOpacity(0.5) : AppColors.border,
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ColorFilter.mode(
                Colors.black.withOpacity(0.1),
                BlendMode.srcOver,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.accentColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            widget.skill.icon,
                            color: AppColors.accentColor,
                            size: 28,
                          ),
                        ),
                        // Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.secondaryAccent.withOpacity(0.2)),
                          ),
                          child: Text(
                            widget.skill.category,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.secondaryAccent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      widget.skill.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
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
}
